/// A service to manage user's rewards.

import 'dart:async';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hive/hive.dart';

/// Name of the database and store.
const String _dbName = 'theme';

const _light = 'light';
const _dark = 'dark';
const _system = 'system';
const _default = _system;

/// A DAO to manage current theme.
class ThemeDAO {
  Future<Box<String>> get _db async => Hive.openBox(_dbName);

  /// Returns current theme selected by user.
  Future<ThemeMode> current() async {
    final String theme = (await _db).get(_db, defaultValue: _default);
    if (theme == _light) return ThemeMode.light;
    if (theme == _dark) return ThemeMode.dark;
    return ThemeMode.system;
  }

  /// Sets current theme to [theme].
  Future<void> set(ThemeMode theme) async {
    String themeName = _default;
    if (theme == ThemeMode.light) themeName = _light;
    if (theme == ThemeMode.dark) themeName = _dark;
    if (theme == ThemeMode.system) themeName = _system;
    (await _db).put(_dbName, themeName);
  }
}
