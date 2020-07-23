import 'dart:async';

import 'package:habitflow/models/day.dart';
import 'package:sembast/sembast.dart';
import 'package:habitflow/models/cycle.dart';

import 'db.dart';

const String _storeName = 'cycles';

/// A DAO to manage user's cycle points.
class CyclesDAO {
  final StoreRef<String, Map<String, dynamic>> _store =
      stringMapStoreFactory.store(_storeName);

  Future<Database> get _db async => await DB.instance.database;

  Finder _finder(String id) => Finder(filter: Filter.equals(idKey, id));

  /// Adds a cycle into db.
  Future<void> add(Cycle cycle) async {
    await _store.add(await _db, cycle.toMap());
  }

  /// Returns all cycles sorted by cycle points required.
  Future<List<Cycle>> all() async {
    final Finder finder =
        Finder(sortOrders: <SortOrder>[SortOrder(startKey, false)]);

    final List<RecordSnapshot<String, Map<String, dynamic>>> snapshots =
        await _store.find(
      await _db,
      finder: finder,
    );

    return snapshots
        .map((RecordSnapshot<String, Map<String, dynamic>> snapshot) {
      final Cycle cycle = Cycle.fromMap(snapshot.value);
      cycle.id = snapshot.key;
      return cycle;
    }).toList();
  }

  /// Returns a specific cycle of [date].
  Future<Cycle> getFromDate(DateTime date) async {
    final Finder finder =
        Finder(filter: Filter.equals(startKey, Day.format(date)));
    final RecordSnapshot<String, Map<String, dynamic>> snapshot =
        await _store.findFirst(await _db, finder: finder);
    if (snapshot == null) {
      return null;
    }
    return Cycle.fromMap(snapshot.value);
  }

  /// Updates a cycle in db.
  Future<void> update(Cycle cycle) async {
    await _store.update(
      await _db,
      cycle.toMap(),
      finder: _finder(cycle.id),
    );
  }

  /// Deletes a cycle from db.
  Future<void> delete(Cycle cycle) async {
    await _store.delete(await _db, finder: _finder(cycle.id));
  }

  /// Clears db.
  Future<void> clear() async => await _store.drop(await _db);
}
