/// A service to manage user's habits.

import 'dart:async';

import 'package:sembast/sembast.dart';

import 'package:habitflow/models/habit.dart';
import 'package:habitflow/services/database/database.dart';

/// Name of the database
const String _dbName = 'habits';

/// A DAO to manage user's habits.
class HabitsDAO {
  /// Store of data.
  final StoreRef<String, Map<String, dynamic>> _store =
      stringMapStoreFactory.store(_dbName);

  /// Connection to db.
  Future<Database> get _db async => DB.instance.database(_dbName);

  /// Returns a finder based on filter of [id].
  Finder _finder(String id) => Finder(filter: Filter.byKey(id));

  /// Adds a habit into db.
  Future<void> add(Habit habit) async {
    await _store.add(await _db, habit.toMap());
  }

  /// Returns all habits sorted by habit points required.
  Future<Map<String, Habit>> all() async {
    final List<RecordSnapshot<String, Map<String, dynamic>>> snapshots =
        await _store.find(
      await _db,
      finder: Finder(sortOrders: <SortOrder>[SortOrder(pointsKey)]),
    );

    final List<Habit> habits = snapshots.map(
      (RecordSnapshot<String, Map<String, dynamic>> snapshot) {
        return Habit.fromMap(snapshot.value);
      },
    ).toList();

    return <String, Habit>{for (Habit habit in habits) habit.id: habit};
  }

  /// Updates a habit in db.
  Future<void> update(Habit habit) async {
    await _store.update(
      await _db,
      habit.toMap(),
      finder: _finder(habit.id),
    );
  }

  /// Deletes a habit from db.
  Future<void> delete(Habit habit) async {
    await _store.delete(await _db, finder: _finder(habit.id));
  }

  /// Returns IDs of all habits active on [day].
  Future<List<String>> active(DateTime day) async {
    final List<String> output = <String>[];
    for (final Habit habit in (await all()).values) {
      if (habit.activeDays.contains(day.weekday)) {
        output.add(habit.id);
      }
    }
    return output;
  }

  /// Clears db.
  Future<void> clear() async => _store.drop(await _db);
}
