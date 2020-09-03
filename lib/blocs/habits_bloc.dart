import 'package:flutter/material.dart';
import 'package:habitflow/models/habit.dart';
import 'package:habitflow/services/analytics/analytics.dart';
import 'package:habitflow/services/habits/habits.dart';

/// A Bloc which manages user's habits.
class HabitsBloc extends ChangeNotifier {
  /// Causes update.
  HabitsBloc() {
    _update();
  }

  /// All the habits.
  Map<String, Habit> habits;
  final HabitsDAO _dao = HabitsDAO();

  /// Updates [habits] and sets up notifications.
  Future<void> _update() async {
    habits = await _dao.all();
    notifyListeners();
  }

  /// Adds [habit] into db.
  Future<void> add(Habit habit) async {
    await _dao.add(habit);
    await _update();
    Analytics().logHabit('habit_added', habit);
  }

  /// Deletes [habit]t from db.
  Future<void> delete(Habit habit) async {
    await _dao.delete(habit);
    await _update();
    Analytics().logHabit('habit_deleted', habit);
  }
}
