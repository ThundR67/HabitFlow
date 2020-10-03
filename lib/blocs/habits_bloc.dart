import 'package:flutter/material.dart';
import 'package:habitflow/helpers/logger.dart';
import 'package:habitflow/models/habit.dart';
import 'package:habitflow/services/analytics/analytics.dart';
import 'package:habitflow/services/habits/habits.dart';
import 'package:logger/logger.dart';

/// A Bloc which manages user's habits.
class HabitsBloc extends ChangeNotifier {
  /// All the habits.
  Map<String, Habit> habits;
  final HabitsDAO _dao = HabitsDAO();
  final Logger _log = logger('HabitsBloc');

  /// Causes update.
  HabitsBloc() {
    _update();
  }

  /// Updates [habits] and sets up notifications.
  Future<void> _update() async {
    habits = await _dao.all();
    _log.i('Loaded all habits');
    for (final habit in habits.values) {
      _log.d('${habit.id} : ${habit.name} : ${habit.points}');
    }
    notifyListeners();
  }

  /// Adds [habit] into db.
  Future<void> add(Habit habit) async {
    await _dao.add(habit);
    await _update();
    Analytics().logHabit('habit_added', habit);
    _log.i('Added habit ${habit.id} : ${habit.name} : ${habit.points}');
  }

  /// Deletes [habit]t from db.
  Future<void> delete(Habit habit) async {
    await _dao.delete(habit);
    await _update();
    Analytics().logHabit('habit_deleted', habit);
    _log.i('Deleted habit ${habit.id} : ${habit.name} : ${habit.points}');
  }
}
