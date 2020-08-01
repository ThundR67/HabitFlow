import 'package:flutter/material.dart';

/// Default dark mode.
ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.grey[850],
  accentColor: Colors.blueAccent,
  appBarTheme: AppBarTheme(
    brightness: Brightness.dark,
    color: Colors.grey[850],
    centerTitle: true,
    elevation: 0,
  ),
);
