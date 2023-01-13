import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  ThemeMode currentTheme = ThemeMode.light;
  String currentLang = 'en';

  // observable pattern
  void changeTheme(ThemeMode newMode) {
    currentTheme = newMode;
    notifyListeners();
  }

  // String getMainBackgroundImage() {
  //   return currentTheme == ThemeMode.light
  //       ? 'assets/images/default_bg.png'
  //       : 'assets/images/dark_bg.png';
  // }

  bool isDarkMode() {
    return currentTheme == ThemeMode.dark;
  }

  void changeLocale(String newLocale) {
    currentLang = newLocale;
    notifyListeners();
  }
}
