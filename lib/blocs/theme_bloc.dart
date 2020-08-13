import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:habitflow/resources/themes.dart';
import 'package:habitflow/services/theme/theme.dart';

/// Name of light theme.
const light = 'light';

/// Name of dark theme.
const dark = 'dark';

/// Name of system theme.
const system = 'system';

/// A bloc to manage current theme.
class ThemeBloc extends ChangeNotifier {
  /// Sets [themes] and [currentTheme].
  ThemeBloc() {
    final brightness = SchedulerBinding.instance.window.platformBrightness;
    themes = {
      light: lightTheme(),
      dark: darkTheme(),
      system: brightness == Brightness.light ? lightTheme() : darkTheme(),
    };
    _dao.current().then((value) {
      current = value ?? system;
      notifyListeners();
    });
  }

  /// All the themes.
  Map<String, ThemeData> themes;

  /// Name of current theme.
  String current;
  final ThemeDAO _dao = ThemeDAO();

  /// Sets [current] theme to [name].
  void set(String name) {
    _dao.set(name);
    current = name;
    notifyListeners();
  }
}
