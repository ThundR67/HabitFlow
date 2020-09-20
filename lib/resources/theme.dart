import 'package:flutter/material.dart';

const _habitflowPrimary = Colors.blue;
const _redAccent400 = Color(0xFFFF1744);

/// Light theme for habitflow.
ThemeData lightTheme = _theme(_lightColorScheme);

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
      shape: _roundedRec(12.0),
      margin: const EdgeInsets.all(8.0),
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
