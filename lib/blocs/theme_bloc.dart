import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:habitflow/resources/themes.dart';
import 'package:habitflow/services/theme/theme.dart';

/// A bloc to manage current theme.
class ThemeBloc extends ChangeNotifier {
  /// Current theme.
  ThemeData theme = lightTheme();

  /// Current theme mode.
  ThemeMode mode = ThemeMode.light;

  final ThemeDAO _dao = ThemeDAO();

  /// Changes current theme to [toTheme] and updates.
  void set(ThemeMode toTheme) {
    _dao.set(toTheme);
    if (toTheme == ThemeMode.light) theme = lightTheme();
    if (toTheme == ThemeMode.dark) theme = darkTheme();
    if (toTheme == ThemeMode.system) {
      final Brightness brightness =
          SchedulerBinding.instance.window.platformBrightness;
      if (brightness == Brightness.dark) theme = darkTheme();
      if (brightness == Brightness.light) theme = lightTheme();
    }
    notifyListeners();
  }
}
