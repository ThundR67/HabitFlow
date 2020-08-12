/// A service to manage all introductions.
import 'dart:async';

import 'package:hive/hive.dart';

import 'package:habitflow/services/database/database.dart';

/// Name of the database
const String _dbName = 'introduction';

/// A DAO to manage all introductions.
class IntroDAO {
  /// Connection to db.
  Future<Box> get _db async => await DB2.instance.open(_dbName);

  /// Set an intro as true.
  Future<void> introShown(String name) async {
    await (await _db).put(name, true);
  }

  /// Returns if an intro is true.
  Future<bool> isShown(String name) async {
    return (await _db).get(name, defaultValue: false) as bool;
  }

  /// Clears db.
  Future<void> clear() async => (await _db).clear();
}
