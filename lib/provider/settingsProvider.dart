import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  ThemeMode currentTheme = ThemeMode.light;
  String currentLang = 'en';

  // observable pattern
  void changeTheme(ThemeMode newMode) async {
    final prefsTheme = await SharedPreferences.getInstance();
    if (newMode == currentTheme) {
      return;
    }
    currentTheme = newMode;
    prefsTheme.setString(
        "theme", (currentTheme == ThemeMode.dark) ? 'dark' : 'light');
    notifyListeners();
  }

  bool isDarkMode() {
    return currentTheme == ThemeMode.dark;
  }

  void changeLocale(String newLocale) async {
    final prefsLocal = await SharedPreferences.getInstance();
    if (newLocale == currentLang) {
      return;
    }
    currentLang = newLocale;
    await prefsLocal.setString("local", currentLang);
    notifyListeners();
  }
}
