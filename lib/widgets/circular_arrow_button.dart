import 'package:flutter/material.dart';
import 'dart:math' as math;

class CircularArrowButton extends StatefulWidget {
  final VoidCallback onPressed;
  final double
  progress; // 0.25 for quarter, 0.5 for half, 0.75 for three-quarters, 1.0 for full

  const CircularArrowButton({
    Key? key,
    required this.onPressed,
    required this.progress,
  }) : super(key: key);

  @override
  _CircularArrowButtonState createState() => _CircularArrowButtonState();
}

class _CircularArrowButtonState extends State<CircularArrowButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0,
      end: widget.progress,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.forward(from: 0);
        widget.onPressed();
      },
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF30ED30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Center(
              child: Icon(Icons.arrow_forward, color: Colors.white, size: 24),
            ),
            SizedBox(
              width: 70,
              height: 70,
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return CustomPaint(
                    painter: CircularProgressPainter(
                      progress: _animation.value,
                      color: Color(0xFF30ED30),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CircularProgressPainter extends CustomPainter {
  final double progress;
  final Color color;

  CircularProgressPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Color(0xFF30ED30)
          ..strokeWidth = 2.5
          ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) + 4; // Added 4 pixels gap from the button

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
