import 'package:flutter/material.dart';

class AppThemes {
  static final ThemeData light = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.black,
    colorScheme: ColorScheme.light(
      primary: Colors.black,
      secondary: Colors.redAccent,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    ),
  );
  static final ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.red,
    colorScheme: ColorScheme.dark(
      primary: Colors.red,
      secondary: Colors.redAccent,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
      ),
    ),
    appBarTheme: const AppBarTheme(
      foregroundColor: Colors.white,
    )
  );
  static final List<ThemeData> llistaTemes = [light, dark];
  static final List<String> nomsTemes = ['Light', 'Dark'];
}
