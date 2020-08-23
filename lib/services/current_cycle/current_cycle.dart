/// A service to manage user's current cycle.

import 'dart:async';

import 'package:hive/hive.dart';

import 'package:habitflow/models/cycle.dart';

/// Name of the db.
const String _dbName = 'current_cycle';

/// A DAO to manage user's current cycle .
class CurrentCycleDAO {
  /// Store of data.
  Future<Box<Cycle>> get _db async => Hive.openBox<Cycle>(_dbName);

  /// Adds [cycle] into db.
  Future<void> create(Cycle cycle) async => (await _db).put(_dbName, cycle);

  /// Returns current cycle.
  Future<Cycle> get() async => (await _db).get(_dbName);

  /// Updates current cycle.
  Future<void> update(Cycle cycle) async => create(cycle);

  /// Closes connection to db.
  Future<void> close() async => (await _db).close();

  /// Clears db.
  Future<void> clear() async => (await _db).clear();
}
