import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'dart:math' show pi, sin;

class AIAssistantPage extends StatefulWidget {
  @override
  _AIAssistantPageState createState() => _AIAssistantPageState();
}

class _AIAssistantPageState extends State<AIAssistantPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _messages = [];
  final FlutterTts flutterTts = FlutterTts();
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _initTts();
    _initSpeech();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _initTts() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.5);
  }

  void _initSpeech() async {
    bool available = await _speech.initialize();
    if (available) {
      setState(() => _isListening = false);
    }
  }

  Future<void> _speak(String text) async {
    await flutterTts.speak(text);
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (result) {
            setState(() {
              _messageController.text = result.recognizedWords;
              if (result.finalResult) {
                _isListening = false;
              }
            });
          },
          listenFor: Duration(seconds: 30),
          cancelOnError: true,
          partialResults: true,
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  void _handleAIResponse(String userMessage) {
    String aiResponse = '';

    userMessage = userMessage.toLowerCase();
    if (userMessage.contains('hi') || userMessage.contains('hello')) {
      aiResponse = 'Hello! How can I help you with your health today?';
    } else if (userMessage.contains('how are you')) {
      aiResponse = 'I\'m functioning perfectly! How are you feeling today?';
    } else if (userMessage.contains('what')) {
      aiResponse =
          'I\'m your AI health assistant. I can help you with health-related questions and advice.';
    } else {
      aiResponse =
          'I\'m here to help! Could you please be more specific about your health-related question?';
    }

    setState(() {
      _messages.add({'type': 'ai', 'text': aiResponse});
    });
  }

  Widget _buildMessageBubble(Map<String, String> message) {
    final isUser = message['type'] == 'user';
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          left: isUser ? 50 : 10,
          right: isUser ? 10 : 50,
          top: 8,
          bottom: 8,
        ),
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isUser ? Color(0xFF86E200) : Color(0xFF282828),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(isUser ? 20 : 0),
                  bottomRight: Radius.circular(isUser ? 0 : 20),
                ),
                boxShadow: [
                  BoxShadow(
                    color:
                        isUser
                            ? Color(0xFF86E200).withOpacity(0.3)
                            : Colors.black26,
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      message['text'] ?? '',
                      style: TextStyle(
                        color: isUser ? Color(0xFF181818) : Color(0xFF86E200),
                        fontSize: 16,
                      ),
                    ),
                  ),
                  if (!isUser) ...[
                    SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => _speak(message['text'] ?? ''),
                      child: Icon(
                        Icons.volume_up,
                        size: 20,
                        color: Color(0xFF86E200),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingAnimation() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Container(
          height: 120,
          width: 200,
          child: CustomPaint(
            painter: SiriWavePainter(
              animationValue: _animationController.value,
              color: Color(0xFF86E200),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSendButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF86E200), Color(0xFF66B100)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Color(0xFF86E200).withOpacity(0.4),
            blurRadius: 12,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: () {
            if (_messageController.text.isNotEmpty) {
              final userMessage = _messageController.text;
              setState(() {
                _messages.add({'type': 'user', 'text': userMessage});
              });
              _messageController.clear();
              _handleAIResponse(userMessage);
            }
          },
          child: Container(
            padding: EdgeInsets.all(12),
            child: Icon(Icons.send_rounded, color: Color(0xFF181818), size: 24),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF181818),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'AI Health Assistant',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF86E200),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF86E200)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: Color(0xFF181818)),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      return _buildMessageBubble(_messages[index]);
                    },
                  ),
                  if (_messages.isEmpty)
                    Center(child: _buildLoadingAnimation()),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFF282828),
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 15,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      cursorColor: Color(0xFF86E200),
                      style: TextStyle(color: Color(0xFF86E200)),
                      decoration: InputDecoration(
                        hintText: 'Type your message...',
                        hintStyle: TextStyle(
                          color: Color(0xFF86E200).withOpacity(0.5),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Color(0xFF282828),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  GestureDetector(
                    onTap: _listen,
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color:
                            _isListening
                                ? Color(0xFF86E200)
                                : Color(0xFF282828),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color:
                                _isListening
                                    ? Color(0xFF86E200).withOpacity(0.3)
                                    : Colors.transparent,
                            blurRadius: 12,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Icon(
                        _isListening ? Icons.mic : Icons.mic_none,
                        color:
                            _isListening
                                ? Color(0xFF181818)
                                : Color(0xFF86E200),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  _buildSendButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SiriWavePainter extends CustomPainter {
  final double animationValue;
  final Color color;

  SiriWavePainter({required this.animationValue, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.5;

    final w = size.width;
    final h = size.height;
    final baseHeight = h * 0.5;

    final path = Path();
    path.moveTo(0, baseHeight);

    for (double i = 0; i < w; i++) {
      final stepValue = i / w;
      final offset = sin(stepValue * 8 + animationValue * 2 * pi) * 15;
      final normalizedHeight = baseHeight + offset;

      // Add wave distortion
      final distortion = sin(stepValue * 4 + animationValue * 2 * pi) * 5;
      path.lineTo(i, normalizedHeight + distortion);
    }

    final wavePaint =
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3
          ..strokeCap = StrokeCap.round
          ..maskFilter = MaskFilter.blur(BlurStyle.solid, 2);

    canvas.drawPath(path, wavePaint);

    // Draw additional waves with different phases
    for (int i = 1; i <= 2; i++) {
      final phasePath = Path();
      phasePath.moveTo(0, baseHeight);

      for (double x = 0; x < w; x++) {
        final step = x / w;
        final phase = i * pi / 4;
        final offset = sin(step * 8 + animationValue * 2 * pi + phase) * 12;
        final yPos = baseHeight + offset;
        phasePath.lineTo(x, yPos);
      }

      final phasePaint =
          Paint()
            ..color = color.withOpacity(0.3)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2
            ..strokeCap = StrokeCap.round
            ..maskFilter = MaskFilter.blur(BlurStyle.solid, 1);

      canvas.drawPath(phasePath, phasePaint);
    }
  }

  @override
  bool shouldRepaint(covariant SiriWavePainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
