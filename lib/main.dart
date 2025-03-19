import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:smart_health/providers/theme_provider.dart';
import 'screens/splashscreen/splash_screen.dart';
import 'firebase_options.dart';
import 'package:smart_health/widgets/auth_wrapper.dart';
import 'package:smart_health/utils/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    bool isFirstLaunch = true; // Default to true to show splash screen
    try {
      final prefs = await SharedPreferences.getInstance();
      isFirstLaunch = prefs.getBool('first_launch') ?? true;
      await prefs.setBool('first_launch', false);
    } catch (e) {
      print('SharedPreferences error: $e');
      // Keep isFirstLaunch as true if there's an error
    }

    runApp(
      ChangeNotifierProvider(
        create: (_) => ThemeProvider(),
        child: MyApp(showSplash: true), // Always show splash on fresh start
      ),
    );
  } catch (e) {
    print('Initialization error: $e');
    runApp(
      MaterialApp(
        home: Scaffold(body: Center(child: Text('Failed to initialize app'))),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  final bool showSplash;
  const MyApp({super.key, required this.showSplash});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Smart Health',
          theme: ThemeData(
            primarySwatch: Colors.green,
            brightness: Brightness.light,
            scaffoldBackgroundColor: Colors.grey[100],
            cardColor: Colors.white,
          ),
          darkTheme: ThemeData(
            primarySwatch: Colors.green,
            brightness: Brightness.dark,
            scaffoldBackgroundColor: Colors.grey[900],
            cardColor: Colors.grey[800],
          ),
          themeMode:
              themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: showSplash ? SplashScreen() : const AuthWrapper(),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RouteGuard.generateRoute,
        );
      },
    );
  }
}
