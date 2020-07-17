import 'dart:async';

import 'package:sembast/sembast.dart';
import 'package:habitflow/models/day.dart';

import 'db.dart';

const String _storeName = 'days';

/// A DAO to manage user's day points.
class DaysDAO {
  final StoreRef<String, Map<String, dynamic>> _store =
      stringMapStoreFactory.store(_storeName);

  Future<Database> get _db async => await DB.instance.database;

  Finder _finder(String id) => Finder(filter: Filter.byKey(id));

  /// Adds a day into db.
  Future<void> add(Day day) async {
    await _store.add(await _db, day.toMap());
  }

  /// Returns all days sorted by day points required.
  Future<List<Day>> all() async {
    final Finder finder = Finder(sortOrders: <SortOrder>[SortOrder(dateKey)]);

    final List<RecordSnapshot<String, Map<String, dynamic>>> snapshots =
        await _store.find(
      await _db,
      finder: finder,
    );

    return snapshots
        .map((RecordSnapshot<String, Map<String, dynamic>> snapshot) {
      final Day day = Day.fromMap(snapshot.value);
      day.id = snapshot.key;
      return day;
    }).toList();
  }

  /// Returns a specific day.
  Future<Day> getDay(DateTime date) async {
    final Finder finder =
        Finder(filter: Filter.equals(dateKey, Day.format(date)));
    final RecordSnapshot<String, Map<String, dynamic>> snapshot =
        await _store.findFirst(await _db, finder: finder);
    return Day.fromMap(snapshot.value);
  }

  /// Updates a day in db.
  Future<void> update(Day day) async {
    await _store.update(
      await _db,
      day.toMap(),
      finder: _finder(day.id),
    );
  }

  /// Deletes a day from db.
  Future<void> delete(Day day) async {
    await _store.delete(await _db, finder: _finder(day.id));
  }

  /// Clears db.
  Future<void> clear() async => await _store.drop(await _db);
}
