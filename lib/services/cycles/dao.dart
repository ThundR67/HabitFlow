import 'dart:async';

import 'package:sembast/sembast.dart';
import 'package:habitflow/models/cycle.dart';

import 'db.dart';

const String _storeName = 'cycles';

/// A DAO to manage user's cycle points.
class CyclesDAO {
  final StoreRef<String, Map<String, dynamic>> _store =
      stringMapStoreFactory.store(_storeName);

  Future<Database> get _db async => await DB.instance.database;

  /// Adds a cycle into db.
  Future<void> add(Cycle cycle) async {
    await _store.add(await _db, cycle.toMap());
  }

  /// Updates a cycle.
  Future<void> update(Cycle cycle) async {
    final Finder finder = Finder(filter: Filter.equals(idKey, cycle.id));
    await _store.update(await _db, cycle.toMap(), finder: finder);
  }

  /// Returns all cycles sorted by cycle start dates and with key id.
  Future<Map<String, Cycle>> all() async {
    final Finder finder =
        Finder(sortOrders: <SortOrder>[SortOrder(startKey, false)]);

    final List<RecordSnapshot<String, Map<String, dynamic>>> snapshots =
        await _store.find(
      await _db,
      finder: finder,
    );

    final List<Cycle> cycles =
        snapshots.map((RecordSnapshot<String, Map<String, dynamic>> snapshot) {
      final Cycle cycle = Cycle.fromMap(snapshot.value);
      cycle.id = snapshot.key;
      return cycle;
    }).toList();

    return <String, Cycle>{for (Cycle e in cycles) e.id: e};
  }

  /// Clears db.
  Future<void> clear() async => await _store.drop(await _db);
}
