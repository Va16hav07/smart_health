import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_health/widgets/auth_wrapper.dart';
import 'splash_screen2.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Removing auto-navigation
  }

  void _handleGetStarted() {
    // Check if user is new
    bool isNewUser = true; // You should implement actual check here
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => isNewUser ? SplashScreen2() : const AuthWrapper(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color(0xFF30ED30).withOpacity(0.1)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Color(0xFF30ED30),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF30ED30).withOpacity(0.3),
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.favorite,
                          size: 60,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 40),
                      Text(
                        'Smart Health',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2E3E5C),
                          letterSpacing: 1.2,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Your Wellness, Our Priority!',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF78839C),
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(height: 60),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 40, left: 24, right: 24),
                child: Container(
                  width: double.infinity,
                  height: 56,
                  child:
                      Theme.of(context).platform == TargetPlatform.iOS
                          ? CupertinoButton(
                            color: Color(0xFF30ED30),
                            borderRadius: BorderRadius.circular(28),
                            padding: EdgeInsets.zero,
                            onPressed: _handleGetStarted,
                            child: Text(
                              'Get Started',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                letterSpacing: 1.0,
                              ),
                            ),
                          )
                          : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF30ED30),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28),
                              ),
                              elevation: 3,
                            ),
                            onPressed: _handleGetStarted,
                            child: Text(
                              'Get Started',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
