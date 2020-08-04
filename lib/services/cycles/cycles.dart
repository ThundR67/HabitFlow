/// A service to manage user's previous cycles.

import 'dart:async';

import 'package:sembast/sembast.dart';

import 'package:habitflow/models/cycle.dart';
import 'package:habitflow/services/database/database.dart';

/// Name of db.
const String _dbName = 'cycles';

/// A DAO to manage user's previous cycles.
class CyclesDAO {
  /// Store of data.
  final StoreRef<String, Map<String, dynamic>> _store =
      stringMapStoreFactory.store(_dbName);

  /// Connection to db.
  Future<Database> get _db async => await DB.instance.database(_dbName);

  /// Adds a cycle into db.
  Future<void> add(Cycle cycle) async {
    await _store.add(await _db, cycle.toMap());
  }

  /// Returns all cycles reversly sorted by cycle start dates.
  Future<Map<String, Cycle>> all() async {
    final List<RecordSnapshot<String, Map<String, dynamic>>> snapshots =
        await _store.find(
      await _db,
      finder: Finder(sortOrders: <SortOrder>[SortOrder(startKey, false)]),
    );

    final List<Cycle> cycles = snapshots.map(
      (RecordSnapshot<String, Map<String, dynamic>> snapshot) {
        return Cycle.fromMap(snapshot.value);
      },
    ).toList();

    return <String, Cycle>{for (Cycle cycle in cycles) cycle.id: cycle};
  }

  /// Clears db.
  Future<void> clear() async => await _store.drop(await _db);
}
