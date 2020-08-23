/// A service to manage user's current theme.

import 'dart:async';

import 'package:hive/hive.dart';

/// Name of the database and store.
const String _dbName = 'theme';

/// A DAO to manage current theme.
class ThemeDAO {
  Future<Box<String>> get _db async => Hive.openBox<String>(_dbName);

  /// Returns current theme selected by user.
  Future<String> current() async => (await _db).get(_dbName);

  /// Sets current theme to [name].
  Future<void> set(String name) async => (await _db).put(_dbName, name);
}
