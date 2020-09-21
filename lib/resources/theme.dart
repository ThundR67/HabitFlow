import 'package:flutter/material.dart';

const _habitflowPrimary = Colors.blue;
const _redAccent400 = Color(0xFFFF1744);
const _darkBackground = Color(0xFF121212);

/// Light theme for habitflow.
ThemeData lightTheme = _theme(_lightColorScheme);

/// Dark theme for habitflow.
ThemeData darkTheme = _theme(_darkColorScheme);

const _lightColorScheme = ColorScheme(
  primary: _habitflowPrimary,
  primaryVariant: _habitflowPrimary,
  secondary: _habitflowPrimary,
  secondaryVariant: _habitflowPrimary,
  surface: Colors.white,
  background: Colors.white,
  error: _redAccent400,
  onPrimary: Colors.white,
  onSecondary: Colors.white,
  onSurface: Colors.black,
  onBackground: Colors.black,
  onError: Colors.white,
  brightness: Brightness.light,
);

const _darkColorScheme = ColorScheme(
  primary: _habitflowPrimary,
  primaryVariant: _habitflowPrimary,
  secondary: _habitflowPrimary,
  secondaryVariant: _habitflowPrimary,
  surface: _darkBackground,
  background: _darkBackground,
  error: _redAccent400,
  onPrimary: Colors.white,
  onSecondary: Colors.white,
  onSurface: Colors.white,
  onBackground: Colors.white,
  onError: Colors.white,
  brightness: Brightness.dark,
);

/// Returns a Rounded Rectangle Shape with [radius].
RoundedRectangleBorder _roundedRec(double radius) {
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(radius),
  );
}

/// Generates [ThemeData] based on [scheme].
ThemeData _theme(ColorScheme scheme) {
  return ThemeData(
    /// Colors.
    brightness: scheme.brightness,
    backgroundColor: scheme.background,
    scaffoldBackgroundColor: scheme.background,
    primaryColor: scheme.primary,
    accentColor: scheme.primary,
    colorScheme: scheme,

    /// Bottom Bar theming.
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      showUnselectedLabels: false,
      elevation: 8.0,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.w700),
    ),

    /// App bar theming.
    appBarTheme: AppBarTheme(
      elevation: 0,
      color: scheme.background,
      centerTitle: true,
      iconTheme: IconThemeData(color: scheme.onBackground),
    ),

    /// Card theming.
    cardTheme: CardTheme(
      elevation: 6.0,
      shape: _roundedRec(16.0),
      margin: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
    ),

    /// Floating action bar theming.
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: scheme.background,
      foregroundColor: scheme.primary,
    ),

    /// Button theming.
    buttonTheme: ButtonThemeData(
      shape: _roundedRec(100),
    ),

    /// Input Text Field theming.
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
      ),
    ),

    /// SnackBar theming.
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: _roundedRec(16.0),
    ),

    /// Dialog theming.
    dialogTheme: DialogTheme(
      shape: _roundedRec(16.0),
    ),

    /// Time picker theming.
    timePickerTheme: TimePickerThemeData(
      shape: _roundedRec(16.0),
      dayPeriodShape: _roundedRec(16.0),
      hourMinuteShape: _roundedRec(16.0),
    ),

    /// Bottom sheet theming.
    bottomSheetTheme: const BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(8.0),
        ),
      ),
    ),

    /// Popup menu theming.
    popupMenuTheme: PopupMenuThemeData(
      shape: _roundedRec(16.0),
    ),

    /// Page Transition theming.
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
      },
    ),
  );
}
