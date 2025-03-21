import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:smart_health/providers/theme_provider.dart';
import 'screens/splashscreen/splash_screen.dart';
import 'firebase_options.dart';
import 'package:smart_health/utils/routes.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    runApp(
      ChangeNotifierProvider(
        create: (_) => ThemeProvider(),
        child: const RouterWrapper(child: MyApp()),
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

class RouterWrapper extends StatelessWidget {
  final Widget child;
  const RouterWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
          home:  SplashScreen(),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RouteGuard.generateRoute,
        );
      },
    );
  }
}
