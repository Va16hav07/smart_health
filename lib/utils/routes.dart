import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_health/screens/loginsignup/login.dart';
import 'package:smart_health/screens/loginsignup/register.dart';
import 'package:smart_health/home/dashboard.dart';

class RouteNames {
  static const String login = '/login';
  static const String signup = '/signup';
  static const String dashboard = '/dashboard';
}

class RouteGuard {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    if (FirebaseAuth.instance.currentUser == null) {
      // If not authenticated, only allow access to login and register pages
      if (settings.name != RouteNames.login &&
          settings.name != RouteNames.signup) {
        return MaterialPageRoute(builder: (_) => const LoginPage());
      }
    }

    switch (settings.name) {
      case RouteNames.login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case RouteNames.signup:
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case RouteNames.dashboard:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(
                body: Center(child: Text('Route ${settings.name} not found')),
              ),
        );
    }
  }
}
