import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:logger/logger.dart';

import 'package:habitflow/helpers/logger.dart';
import 'package:habitflow/resources/theme.dart';
import 'package:habitflow/services/analytics/analytics.dart';
import 'package:habitflow/services/theme/theme.dart';

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

/// Sets status bar color according to [mode].
Future _setStatusBar(ThemeMode mode) async {
  final brightness = SchedulerBinding.instance.window.platformBrightness;
  final isLight = brightness == Brightness.light;

  final Map<ThemeMode, ThemeData> themes = {
    ThemeMode.light: lightTheme,
    ThemeMode.dark: darkTheme,
    ThemeMode.system: isLight ? lightTheme : darkTheme,
  };

  final ThemeData theme = themes[mode];

  await FlutterStatusbarcolor.setNavigationBarColor(theme.colorScheme.surface);
  await FlutterStatusbarcolor.setNavigationBarWhiteForeground(!isLight);
  await FlutterStatusbarcolor.setStatusBarWhiteForeground(!isLight);
}

/// A bloc to manage current theme.
class ThemeBloc extends ChangeNotifier {
  final ThemeDAO _dao = ThemeDAO();
  final Logger _log = logger('ThemeBloc');

  /// Current ThemeMode.
  ThemeMode current;

  /// Sets [current] to current theme mode.
  ThemeBloc() {
    _dao.current().then((value) async {
      await FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
      current = _nameToMode(value);
      _setStatusBar(current);
      _log.i('Current theme loded: $value');
      notifyListeners();
    });
  }

  /// Sets [current] to ThemeMode of [name].
  Future set(String name) async {
    _log.i('Current theme changed to: $name');
    current = _nameToMode(name);
    await _setStatusBar(current);
    notifyListeners();
    _dao.set(name);
    Analytics().logSimple('theme_changed', {'name': name});
  }
}
