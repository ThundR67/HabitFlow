import 'package:flutter/material.dart';

/// Default dark mode.
ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.grey[900],
  accentColor: Colors.blueAccent,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.grey[900],
  ),
  appBarTheme: AppBarTheme(
    brightness: Brightness.dark,
    color: Colors.grey[900],
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
