import 'package:flutter/material.dart';

import 'package:habitflow/models/habit.dart';
import 'package:habitflow/services/habits/habits.dart';

/// A Bloc which manages user's habits.
class HabitsBloc extends ChangeNotifier {
  /// Causes a update as soon as bloc is initialized.
  HabitsBloc() {
    _update();
  }

  final HabitsDAO _dao = HabitsDAO();

  /// All the habits.
  Map<String, Habit> habits;

  /// Updates [habits].
  Future<void> _update() async {
    habits = await _dao.all();
    notifyListeners();
  }

  /// Adds [habit] into db.
  Future<void> add(Habit habit) async {
    await _dao.add(habit);
    await _update();
  }

  /// Updates [habit] in db.
  Future<void> update(Habit habit) async {
    await _dao.update(habit);
    await _update();
  }

  /// Deletes [habit]t from db.
  Future<void> delete(Habit habit) async {
    await _dao.delete(habit);
    await _update();
  }
}
