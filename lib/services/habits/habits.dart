/// A service to manage user's habits.

import 'dart:async';

import 'package:hive/hive.dart';

import 'package:habitflow/models/habit.dart';
import 'package:habitflow/services/database/database.dart';

/// Name of the database
const String _dbName = 'habits';

/// A DAO to manage user's habits.
class HabitsDAO {
  Future<Box<Habit>> get _db async => DB.instance.open<Habit>(_dbName);

  /// Adds a habit into db.
  Future<void> add(Habit habit) async => (await _db).put(habit.id, habit);

  /// Returns all habits sorted by habit points required.
  Future<Map<String, Habit>> all() async {
    final List<Habit> habits = (await _db).values.toList();
    return {for (final habit in habits) habit.id: habit};
  }

  /// Deletes a habit from db.
  Future<void> delete(Habit habit) async => (await _db).delete(habit.id);

  /// Returns IDs of all habits active on [day].
  Future<List<String>> active(DateTime day) async {
    final List<String> output = <String>[];
    for (final Habit habit in (await all()).values) {
      if (habit.goal.activeDays.contains(day.weekday)) {
        output.add(habit.id);
      }
    }
    return output;
  }

  /// Closes connection to db.
  Future<void> close() async => (await _db).close();

  /// Clears db.
  Future<void> clear() async => (await _db).clear();
}
