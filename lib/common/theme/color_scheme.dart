import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: const Color(0xFFF5F5F5),
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF1976D2),
    onPrimary: Colors.white,
    secondary: Color(0xFF03DAC6),
    onSecondary: Colors.black,
    error: Color(0xFFB00020),
    onError: Colors.white,
    surface: Color(0xFFFFFFFF),
    onSurface: Color(0xFF1A1A1A),
  ),
);

final ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: const Color(0xFF121212),
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF90CAF9),
    onPrimary: Color(0xFF00325B),
    secondary: Color(0xFF03DAC6),
    onSecondary: Colors.black,
    error: Color(0xFFCF6679),
    onError: Colors.black,
    surface: Color(0xFF1E1E1E),
    onSurface: Color(0xFFE0E0E0),
  ),
);

const Color cardNumColor = Color(0xFF10C300);