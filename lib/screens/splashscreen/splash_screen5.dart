import 'package:flutter/material.dart';
import 'package:smart_health/screens/loginsignup/login.dart';
import '../../widgets/circular_arrow_button.dart';

class SplashScreen5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/splashscreen5.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                  Text(
                    'Improve Sleep Quality',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Improve the quality of your sleep with us, good quality sleep can bring a good mood in the morning',
                    textAlign: TextAlign.left, // Changed from center to left
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 20,
            bottom: 40,
            child: CircularArrowButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder:
                        (context, animation, secondaryAnimation) =>
                            const LoginPage(),
                    transitionsBuilder: (
                      context,
                      animation,
                      secondaryAnimation,
                      child,
                    ) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    transitionDuration: Duration(milliseconds: 500),
                  ),
                );
              },
              progress: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: SplashScreen5()));
}
