import 'package:flutter/material.dart';

class MyTheme {
  static const Color lightPrimary = Color(0xFF5D9CEC);
  static const Color lightScaffoldBackground = Color(0xFFDFECDB);
  static const Color colorGrey = Color(0xFFC8C9CB);
  static const Color greenColor = Color(0xFF61E757);
  static const Color darkScaffoldBackground = Color(0xFF060E1E);
  static const Color darkPrimary = Color(0xFF141922);

  static final lightTheme = ThemeData(
      primaryColor: lightPrimary,
      scaffoldBackgroundColor: lightScaffoldBackground,
      appBarTheme: const AppBarTheme(
        color: lightPrimary,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedIconTheme: IconThemeData(color: lightPrimary, size: 30),
        unselectedIconTheme: IconThemeData(size: 30, color: colorGrey),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18)))),
      textTheme: const TextTheme(
          headline5: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          headline6: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          )));

  //////////////////////////////////////////////////////////////////////////////////////////////////////////

  static final darkTheme = ThemeData(
    primaryColor: lightPrimary,
    scaffoldBackgroundColor: darkScaffoldBackground,
    appBarTheme: const AppBarTheme(
        color: lightPrimary,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 25,
        )),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedIconTheme: IconThemeData(color: lightPrimary, size: 30),
      unselectedIconTheme: IconThemeData(size: 30, color: colorGrey),
      backgroundColor: darkPrimary,
      elevation: 0,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: darkPrimary,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18), topRight: Radius.circular(18)))),
    textTheme: const TextTheme(
        headline5: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        headline6: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
  );
}
