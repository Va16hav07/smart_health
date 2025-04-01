import 'package:flutter/material.dart';
import 'splashscreentwo.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF181818),
      body: SafeArea(
        child: Column(
          children: [
            const Expanded(flex: 3, child: SizedBox()),
            const Text(
              'Welcome To',
              style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 0), 
            const Text(
              'Smart Health',
              style: TextStyle(
                fontSize: 55,
                fontWeight: FontWeight.bold,
                color: Color(0xFF86E200),
              ),
            ),
            const SizedBox(height: 4), 
            const Text(
              'Your Wellness, Our Priority!',
              style: TextStyle(fontSize: 19, color: Color(0xFF989898)),
            ),
            const Expanded(flex: 4, child: SizedBox()),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SplashScreenTwo(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF86E200),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30), 
          ],
        ),
      ),
    );
  }
}
