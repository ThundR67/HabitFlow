/// A service to manage user's previous cycles.

import 'dart:async';

import 'package:habitflow/helpers/date_format.dart';
import 'package:hive/hive.dart';

import 'package:habitflow/models/cycle.dart';

/// Name of db.
const String _dbName = 'cycles';

/// A DAO to manage user's previous cycles.
class CyclesDAO {
  Future<Box<Cycle>> get _db async => Hive.openBox(_dbName);

  /// Adds a cycle into db.
  Future<void> add(Cycle cycle) async => (await _db).put(cycle.start, cycle);

  /// Returns all cycles reversly sorted by cycle start dates.
  Future<List<Cycle>> all() async {
    final List<Cycle> cycles = (await _db).values.toList();
    cycles.sort((Cycle a, Cycle b) {
      if (a.start == b.start) return 0;
      if (parseDate(a.start).isAfter(parseDate(b.start))) return -1;
      return 1;
    });
    return cycles;
  }

  /// Closes connection to db.
  Future<void> close() async => (await _db).close();

  /// Clears db.
  Future<void> clear() async => (await _db).clear();
}
