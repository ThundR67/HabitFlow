/// A service to manage user's previous cycles.

import 'dart:async';

import 'package:hive/hive.dart';

import 'package:habitflow/models/cycle.dart';
import 'package:habitflow/services/database/database.dart';

/// Name of db.
const String _dbName = 'cycles';

/// A DAO to manage user's previous cycles.
class CyclesDAO {
  Future<Box<Cycle>> get _db async => DB2.instance.open<Cycle>(_dbName);

  /// Adds a cycle into db.
  Future<void> add(Cycle cycle) async => (await _db).put(cycle.start, cycle);

  /// Returns all cycles reversly sorted by cycle start dates.
  Future<List<Cycle>> all() async => (await _db).values.toList();

  /// Closes connection to db.
  Future<void> close() async => (await _db).close();

  /// Clears db.
  Future<void> clear() async => (await _db).clear();
}
