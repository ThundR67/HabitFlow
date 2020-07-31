import 'dart:async';

import 'package:sembast/sembast.dart';

import 'package:habitflow/models/cycle.dart';
import 'db.dart';

const String _storeName = 'current_cycle';

/// A DAO to manage user's cycle points.
class CurrentCycleDAO {
  final StoreRef<String, Map<String, dynamic>> _store =
      stringMapStoreFactory.store(_storeName);

  Future<Database> get _db async => await DB.instance.database;

  /// Creates a new cycle and adds it into db.
  Future<void> create(Cycle cycle) async {
    /// Clears previous cycle.
    await clear();
    await _store.add(await _db, cycle.toMap());
  }

  /// Returns current cycle.
  Future<Cycle> get() async {
    final RecordSnapshot<String, Map<String, dynamic>> snapshot =
        await _store.findFirst(await _db);
    if (snapshot == null) {
      return null;
    }
    return Cycle.fromMap(snapshot.value);
  }

  /// Updates current cycle.
  Future<void> update(Cycle cycle) async {
    await _store.update(await _db, cycle.toMap());
  }

  /// Clears db.
  Future<void> clear() async => await _store.drop(await _db);
}
