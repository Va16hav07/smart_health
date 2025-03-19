import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;
  final String key = "theme";
  SharedPreferences? prefs;

  bool get isDarkMode => _isDarkMode;

  ThemeProvider() {
    _loadFromPrefs();
  }

  Future<void> _initPrefs() async {
    prefs ??= await SharedPreferences.getInstance();
  }

  Future<void> _loadFromPrefs() async {
    await _initPrefs();
    _isDarkMode = prefs?.getBool(key) ?? false;
    notifyListeners();
  }

  Future<void> _saveToPrefs() async {
    await _initPrefs();
    await prefs?.setBool(key, _isDarkMode);
  }

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    await _saveToPrefs();
    notifyListeners();
  }
}
