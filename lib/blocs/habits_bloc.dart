import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

import 'package:habitflow/models/habit.dart';
import 'package:habitflow/services/habits/habits.dart';

/// A Bloc which does CRUD of habits.
class HabitsBloc extends ChangeNotifier {
  /// Causes a update as soon as bloc is initialized.
  HabitsBloc() {
    /// TODO remove
    _dao.clear().whenComplete(() {
      final Habit data = Habit(
        name: 'Gaming 20 mins',
        points: 30,
        colorHex: '#00e676',
        iconData: iconDataToMap(Icons.gamepad),
      );
      _dao.add(data).whenComplete(_update);
    });
  }

  final HabitsDAO _dao = HabitsDAO();

  /// All the habits.
  List<Habit> habits;

  /// Updates [habits].
  void _update() {
    _dao.all().then((List<Habit> value) {
      habits = value;
      notifyListeners();
    });
  }

  /// Adds a habit into db.
  void add(Habit habit) => _dao.add(habit).whenComplete(_update);

  /// Updates a habit in db.
  void update(Habit habit) => _dao.update(habit).whenComplete(_update);

  /// Deletes a habit from db.
  void delete(Habit habit) => _dao.delete(habit).whenComplete(_update);
}
