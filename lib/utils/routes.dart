import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_health/screens/loginsignup/login.dart';

class RouteGuard {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    if (FirebaseAuth.instance.currentUser == null) {
      // If not authenticated, only allow access to login and register pages
      if (settings.name != '/login' && settings.name != '/register') {
        return MaterialPageRoute(builder: (_) => LoginPage());
      }
    }

    // Add your regular route handling here
    switch (settings.name) {
      // Add your routes here
      default:
        return MaterialPageRoute(
          builder:
              (_) =>
                  const Scaffold(body: Center(child: Text('Route not found'))),
        );
    }
  }
}
