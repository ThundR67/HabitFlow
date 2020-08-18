import 'package:flutter/material.dart';

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
  final ThemeDAO _dao = ThemeDAO();

  /// Name of current theme.
  String current;

  /// All the themes.
  Map<String, ThemeData> themes = {
    light: lightTheme(),
    dark: darkTheme(),
    system: systemTheme(),
  };

  /// Sets [current] to current theme name or defaults to [system].
  ThemeBloc() {
    _dao.current().then((value) {
      current = value ?? system;
      notifyListeners();
    });
  }

  /// Sets [current] theme to [name].
  void set(String name) {
    current = name;
    notifyListeners();
    _dao.set(name);
  }
}
