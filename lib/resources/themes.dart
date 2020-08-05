import 'package:flutter/material.dart';

/// Returns default dark mode.
ThemeData darkTheme() {
  const Color primary = Color(0xFF121212);
  const Brightness brightness = Brightness.dark;
  return ThemeData(
    brightness: brightness,
    scaffoldBackgroundColor: primary,
    accentColor: Colors.blueAccent,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: primary,
    ),
    appBarTheme: const AppBarTheme(
      brightness: brightness,
      color: primary,
      centerTitle: true,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      headline5: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.w800,
      ),
    ),
  );
}

/// Returns default light mode.
ThemeData lightTheme() {
  const Color primary = Color(0xFFEFEEEE);
  const Brightness brightness = Brightness.light;
  return ThemeData(
    brightness: brightness,
    scaffoldBackgroundColor: primary,
    accentColor: Colors.blueAccent,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: primary,
    ),
    appBarTheme: const AppBarTheme(
      brightness: brightness,
      color: primary,
      centerTitle: true,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      headline5: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.w800,
      ),
    ),
  );
}
