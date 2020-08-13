/// A service to manage user's current cycle.

import 'dart:async';

import 'package:hive/hive.dart';

import 'package:habitflow/models/cycle.dart';

/// Name of the db.
const String _dbName = 'current_cycle';

/// A DAO to manage user's current cycle .
class CurrentCycleDAO {
  /// Store of data.
  Future<Box> get _db async => Hive.openBox(_dbName);

  /// Adds [cycle] int db.
  Future<void> create(Cycle cycle) async => (await _db).put(_dbName, cycle);

  /// Returns current cycle.
  Future<Cycle> get() async => (await _db).get(_dbName) as Cycle;

  /// Updates current cycle.
  Future<void> update(Cycle cycle) async => create(cycle);

  /// Closes connection to db.
  Future<void> close() async => (await _db).close();

  /// Clears db.
  Future<void> clear() async => (await _db).clear();
}
