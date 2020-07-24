import 'dart:async';

import 'package:habitflow/models/dates.dart';
import 'package:sembast/sembast.dart';
import 'package:habitflow/models/day.dart';

import 'db.dart';

const String _storeName = 'days';

/// A DAO to manage user's day points.
class DaysDAO {
  final StoreRef<String, Map<String, dynamic>> _store =
      stringMapStoreFactory.store(_storeName);

  Future<Database> get _db async => await DB.instance.database;

  Finder _finder(String id) => Finder(filter: Filter.equals(idKey, id));

  /// Adds a day into db.
  Future<void> add(Day day) async {
    await _store.add(await _db, day.toMap());
  }

  /// Returns all days in map.
  Future<Map<String, Day>> all() async {
    final Finder finder =
        Finder(sortOrders: <SortOrder>[SortOrder(dateKey, false)]);

    final List<RecordSnapshot<String, Map<String, dynamic>>> snapshots =
        await _store.find(
      await _db,
      finder: finder,
    );

    final List<Day> days =
        snapshots.map((RecordSnapshot<String, Map<String, dynamic>> snapshot) {
      final Day day = Day.fromMap(snapshot.value);
      day.id = snapshot.key;
      return day;
    }).toList();

    return <String, Day>{for (Day e in days) e.date: e};
  }

  /// Returns a specific day of [date].
  Future<Day> getFromDate(DateTime date) async {
    final Finder finder =
        Finder(filter: Filter.equals(dateKey, formatDate(date)));
    final RecordSnapshot<String, Map<String, dynamic>> snapshot =
        await _store.findFirst(await _db, finder: finder);
    if (snapshot == null) {
      return null;
    }
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
