import 'package:flutter/material.dart';
import 'splash_screen3.dart';
import 'splash_screen5.dart';

class SplashScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (DragEndDetails details) {
        if (details.primaryVelocity! < 0) {
          // Swipe left - go to next screen
          _navigateToNext(context);
        } else if (details.primaryVelocity! > 0) {
          // Swipe right - go back
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/splashscreen2.png'),
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
                    SizedBox(
                      height:
                          MediaQuery.of(context).size.height *
                          0.3, // Increased from 0.15 to 0.3
                    ),
                    Text(
                      'Track Your Goal',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Don't worry if you have trouble determining your goals, We can help you determine your goals and track your goals",
                      textAlign: TextAlign.left,
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
              child: FloatingActionButton(
                onPressed: () {
                  _navigateToNext(context);
                },
                backgroundColor: Colors.white,
                child: Icon(Icons.arrow_forward, color: Colors.green),
              ),
            ),
            Positioned(
              right: 20,
              top: 40,
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder:
                          (context, animation, secondaryAnimation) =>
                              SplashScreen5(),
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
                child: Text(
                  'Skip',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Update the navigation method
  void _navigateToNext(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder:
            (context, animation, secondaryAnimation) => SplashScreen3(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
        transitionDuration: Duration(milliseconds: 300),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: SplashScreen2()));
}
