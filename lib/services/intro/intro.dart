/// A service to manage all introductions.
import 'dart:async';

import 'package:hive/hive.dart';

/// Name of the database
const String _dbName = 'introduction';

/// A DAO to manage all introductions.
class IntroDAO {
  Future<Box<bool>> get _db async => Hive.openBox(_dbName);

  /// Set an intro as true.
  Future<void> introShown(String name) async => (await _db).put(name, true);

  /// Returns if an intro is true.
  Future<bool> isShown(String name) async =>
      (await _db).get(name, defaultValue: false);

  /// Closes connection to db.
  Future<void> close() async => (await _db).close();

  /// Clears db.
  Future<void> clear() async => (await _db).clear();
}
