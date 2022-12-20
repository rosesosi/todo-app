import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTheme {
  static const Color lightPrimary = Color(0xFF5D9CEC);
  static const Color lightScaffoldBackground = Color(0xFFDFECDB);
  static const Color colorGrey = Color(0xFFC8C9CB);

  static final lightTheme = ThemeData(
      primaryColor: lightPrimary,
      scaffoldBackgroundColor: lightScaffoldBackground,
      appBarTheme: AppBarTheme(
        color: lightPrimary,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedIconTheme: IconThemeData(color: lightPrimary, size: 30),
        unselectedIconTheme: IconThemeData(size: 30, color: colorGrey),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ));
}
