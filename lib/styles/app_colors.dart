import 'package:flutter/material.dart';

class AppColors {
  static const MaterialColor redPalette = MaterialColor(
    0xFFF44336,
    <int, Color> {
      50: Color(0xFFFFEBEE),
      100: Color(0xFFFFCDD2),
      200: Color(0xFFEF9A9A),
      300: Color(0xFFE57373),
      400: Color(0xFFEF5350),
      500: Color(0xFFF8BBD0),
      600: Color(0xFFE53935),
      700: Color(0xFFF48FB1),
      800: Color(0xFFF3E5F5),
      850: Color(0xFFCE93D8),
      900: Color(0xFFC3B1E1),
    },
  );

  static List<Color> colors = [
    Color(0xFFFFEBEE),
    Color(0xFFFFCDD2),
    Color(0xFFEF9A9A),
    Color(0xFFE57373),
    Color(0xFFEF5350),
    Color(0xFFF8BBD0),
    Color(0xFFE53935),
    Color(0xFFF48FB1),
    Color(0xFFF3E5F5),
    Color(0xFFC3B1E1),
  ];

  static Color getRandomColor() {
    colors.shuffle();
    return colors.first;
  }

}


