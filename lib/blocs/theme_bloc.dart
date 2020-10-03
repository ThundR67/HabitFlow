import 'package:flutter/material.dart';
import 'package:habitflow/helpers/logger.dart';

import 'package:habitflow/services/theme/theme.dart';
import 'package:logger/logger.dart';

/// Name of light theme.
const light = 'light';

/// Name of dark theme.
const dark = 'dark';

/// Name of system theme.
const system = 'system';

/// Converts [name] to [ThemeMode].
ThemeMode _nameToMode(String name) {
  ThemeMode mode = ThemeMode.system;
  if (name == dark) mode = ThemeMode.dark;
  if (name == light) mode = ThemeMode.light;
  return mode;
}

/// A bloc to manage current theme.
class ThemeBloc extends ChangeNotifier {
  final ThemeDAO _dao = ThemeDAO();
  final Logger _log = logger('ThemeBloc');

  /// Current ThemeMode.
  ThemeMode current;

  /// Sets [current] to current theme mode.
  ThemeBloc() {
    _dao.current().then((value) {
      current = _nameToMode(value);
      _log.i('Current theme loded: $value');
      notifyListeners();
    });
  }

  /// Sets [current] to ThemeMode of [name].
  void set(String name) {
    _log.i('Current theme changed to: $name');
    current = _nameToMode(name);
    notifyListeners();
    _dao.set(name);
  }
}
