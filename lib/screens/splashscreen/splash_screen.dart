import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_health/widgets/auth_wrapper.dart';
import 'splash_screen2.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();
    _navigationHandler();
  }

  void _navigationHandler() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted && !_hasNavigated) {
        setState(() => _hasNavigated = true);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AuthWrapper()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Smart Health',
                    style: TextStyle(
                      fontSize: 34, // Adjusted for iOS
                      fontWeight: FontWeight.w600, // Less bold for iOS
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Your Wellness, Our Priority!',
                    style: TextStyle(
                      fontSize: 17, // iOS standard font size
                      color: CupertinoColors.secondaryLabel, // iOS native color
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 40),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child:
                  Theme.of(context).platform == TargetPlatform.iOS
                      ? CupertinoButton(
                        color: Color(0xFF30ED30),
                        borderRadius: BorderRadius.circular(30),
                        padding: EdgeInsets.symmetric(
                          horizontal: 80,
                          vertical: 15,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => SplashScreen2(),
                            ),
                          );
                        },
                        child: Text(
                          'Get Started',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                          ),
                        ),
                      )
                      : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF30ED30),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 80,
                            vertical: 15,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SplashScreen2(),
                            ),
                          );
                        },
                        child: Text(
                          'Get Started',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
            ),
          ),
        ],
      ),
    );
  }
}
