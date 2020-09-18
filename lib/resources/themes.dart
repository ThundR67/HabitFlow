import 'package:flutter/material.dart';

/// Returns default dark mode.
ThemeData darkTheme() {
  final Color primary = Colors.grey[900];
  const Brightness brightness = Brightness.dark;
  return ThemeData(
    cardTheme: const CardTheme(
      elevation: 8.0,
      margin: EdgeInsets.all(8.0),
    ),
    brightness: brightness,
    scaffoldBackgroundColor: primary,
    accentColor: Colors.blueAccent,
    buttonColor: Colors.blueAccent,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.grey[850],
      elevation: 24.0,
      selectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w700,
      ),
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w500,
      ),
    ),
    appBarTheme: AppBarTheme(
      brightness: brightness,
      color: primary,
      centerTitle: true,
      elevation: 0,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
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
  const Color primary = Colors.white;
  const Brightness brightness = Brightness.light;
  return ThemeData(
    cardTheme: const CardTheme(
      elevation: 8.0,
      margin: EdgeInsets.all(8.0),
    ),
    brightness: brightness,
    scaffoldBackgroundColor: primary,
    accentColor: Colors.blueAccent,
    buttonColor: Colors.blueAccent,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      showUnselectedLabels: false,
      elevation: 8,
      selectedLabelStyle: TextStyle(
        fontWeight: FontWeight.w700,
      ),
      unselectedLabelStyle: TextStyle(
        fontWeight: FontWeight.w500,
      ),
    ),
    appBarTheme: const AppBarTheme(
      brightness: brightness,
      color: primary,
      centerTitle: true,
      elevation: 0,
      textTheme: TextTheme(
        headline6: TextStyle(
          color: Colors.black,
          fontSize: 24.0,
        ),
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    textTheme: const TextTheme(
      headline5: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.w800,
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      modalBackgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(8.0),
        ),
      ),
    ),
  );
}
