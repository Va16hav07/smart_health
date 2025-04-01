import 'package:flutter/material.dart';
import 'Splash Screen/splashscreenone.dart';
import 'Login&Signup/Login.dart'; // Add this import

void main() {
  runApp(const SmartHealthApp());
}

class SmartHealthApp extends StatelessWidget {
  const SmartHealthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {'/login': (context) => const LoginScreen()},
    );
  }
}
