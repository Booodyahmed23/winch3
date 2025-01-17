import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';  // Import SharedPreferences

class UiProvider extends ChangeNotifier {
  bool _isDark = false;
  bool get isDark => _isDark;

  late SharedPreferences storage;

  final darkTheme = ThemeData(
    primaryColor: Colors.black12,
    brightness: Brightness.dark,
    primaryColorDark: Colors.black12,
  );

  final lightTheme = ThemeData(
    primaryColor: Colors.white,
    brightness: Brightness.light,
    primaryColorDark: Colors.white,
  );

  // Constructor to initialize SharedPreferences and the theme state
  UiProvider() {
    init();
  }

  // Change theme and save the state in SharedPreferences
  void changeTheme() async {
    _isDark = !_isDark;
    await storage.setBool('isDark', _isDark);  // Save theme state to SharedPreferences
    notifyListeners();
  }

  // Initialize the provider and load the theme state from SharedPreferences
  Future<void> init() async {
    storage = await SharedPreferences.getInstance();
    _isDark = storage.getBool('isDark') ?? false;  // Default to false if no value is found
    notifyListeners();
  }
}
