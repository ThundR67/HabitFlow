/// A service to manage all introductions.
import 'dart:async';

import 'package:sembast/sembast.dart';

import 'package:habitflow/services/database/database.dart';

/// Name of the database
const String _dbName = 'introduction';

/// A DAO to manage all introductions.
class IntroDAO {
  /// Store of data.
  final StoreRef<String, bool> _store = StoreRef<String, bool>.main();

  /// Connection to db.
  Future<Database> get _db async => DB.instance.database(_dbName);

  /// Set an intro as true.
  Future<void> introShown(String name) async {
    await _store.record(name).put(await _db, true);
  }

  /// Returns if an intro is true.
  Future<bool> isShown(String name) async {
    return (await _store.record(name).get(await _db)) ?? false;
  }

  /// Clears db.
  Future<void> clear() async => _store.drop(await _db);
}
