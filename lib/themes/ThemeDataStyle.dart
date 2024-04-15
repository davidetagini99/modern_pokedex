// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ThemeDataStyle {
  static ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      background: Colors.white,
      primary: Colors.red,
      secondary: Colors.black,
      tertiary: Color.fromARGB(255, 192, 191, 191),
    ),
  );

  static ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      background: Colors.black,
      primary: Colors.red,
      secondary: Colors.white,
      tertiary: Color.fromARGB(255, 109, 109, 109),
    ),
  );
}