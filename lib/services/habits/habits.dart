import 'dart:async';

import 'package:sembast/sembast.dart';
import 'package:habitflow/models/habit.dart';

import 'db.dart';

const String _storeName = 'habits';

/// A DAO to manage user's habit points.
class HabitsDAO {
  final StoreRef<String, Map<String, dynamic>> _store =
      stringMapStoreFactory.store(_storeName);

  Future<Database> get _db async => await DB.instance.database;

  Finder _finder(String id) => Finder(filter: Filter.byKey(id));

  /// Adds a habit into db.
  Future<void> add(Habit habit) async {
    await _store.add(await _db, habit.toMap());
  }

  /// Returns all habits sorted by habit points required.
  Future<List<Habit>> all() async {
    final Finder finder = Finder(sortOrders: <SortOrder>[SortOrder(pointsKey)]);

    final List<RecordSnapshot<String, Map<String, dynamic>>> snapshots =
        await _store.find(
      await _db,
      finder: finder,
    );

    return snapshots
        .map((RecordSnapshot<String, Map<String, dynamic>> snapshot) {
      final Habit habit = Habit.fromMap(snapshot.value);
      habit.id = snapshot.key;
      return habit;
    }).toList();
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

  /// Returns ids all active habits on [date]
  Future<List<String>> active(DateTime day) async {
    final List<String> output = <String>[];
    final List<Habit> habits = await all();
    for (final Habit habit in habits) {
      if (habit.activeDays.contains(day.weekday)) {
        output.add(habit.id);
      }
    }
    return output;
  }

  /// Clears db.
  Future<void> clear() async => await _store.drop(await _db);
}
