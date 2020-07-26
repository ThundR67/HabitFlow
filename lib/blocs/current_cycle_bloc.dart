import 'package:flutter/material.dart';

import 'package:habitflow/models/cycle.dart';
import 'package:habitflow/models/dates.dart';
import 'package:habitflow/models/day.dart';
import 'package:habitflow/services/current_cycle/current_cycle.dart';
import 'package:habitflow/services/habits/habits.dart';

/// Bloc to manage current cycle
class CurrentCycleBloc extends ChangeNotifier {
  /// Constructs.
  CurrentCycleBloc() {
    _dao.clear().whenComplete(_update);
  }

  final CurrentCycleDAO _dao = CurrentCycleDAO();
  final HabitsDAO _habitsDAO = HabitsDAO();

  /// Current cycle.
  Cycle current = Cycle();

  /// Checks if [current] contains day with [date].
  bool _contains(DateTime date) {
    for (final Day day in current.days) {
      if (day.date == formatDate(date)) {
        return true;
      }
    }
    return false;
  }

  /// Returns index of day with [date] from [current].
  int _getDayIndex(DateTime date) {
    for (final Day day in current.days) {
      if (day.date == formatDate(date)) {
        return current.days.indexOf(day);
      }
    }
    return null;
  }

  /// Unmarks a habit as nothing on [date].
  Future<void> unmark(String id, [DateTime date]) async {
    final int index = _getDayIndex(date ?? DateTime.now());
    current.days[index].successes.remove(id);
    current.days[index].skips.remove(id);
    current.days[index].failures.remove(id);
    await _dao.update(current);
  }

  /// Unmarks a habit as nothing on [date] and updates.
  Future<void> undo(String id, [DateTime date]) async {
    await unmark(id, date);
    await _update();
  }

  /// Marks habit as done on [date].
  Future<void> done(String id, [DateTime date]) async {
    await unmark(id, date);
    final int index = _getDayIndex(date ?? DateTime.now());
    current.days[index].successes.add(id);
    await _dao.update(current);
    await _update();
  }

  /// Marks habit as skipped on [date].
  Future<void> skip(String id, [DateTime date]) async {
    await unmark(id, date);
    final int index = _getDayIndex(date ?? DateTime.now());
    current.days[index].skips.add(id);
    await _dao.update(current);
    await _update();
  }

  /// Marks habit as failed on [date].
  Future<void> fail(String id, String reason, [DateTime date]) async {
    await unmark(id, date);
    final int index = _getDayIndex(date ?? DateTime.now());
    current.days[index].failures[id] = reason;
    await _dao.update(current);
    await _update();
  }

  /// Updates [cycle].
  Future<void> _update() async {
    await _fill();
    current = await _dao.get();
    notifyListeners();
  }

  /// Fills days which weren't recorded.
  Future<void> _fill() async {
    final List<DateTime> dates = getDates(
      parseDate(current.start),
      DateTime.now(),
    );
    for (final DateTime date in dates) {
      await _fillDay(date);
    }
  }

  /// Fills a day with default [Day].
  Future<void> _fillDay(DateTime date) async {
    if (_contains(date)) {
      return;
    }

    final List<String> active = await _habitsDAO.active(date);
    Map<String, String> failures = <String, String>{
      for (String e in active) e: ''
    };
    if (formatDate(date) == formatDate(DateTime.now())) {
      // No failures if [date] is today.
      failures = <String, String>{};
    }

    final Day day = Day(
      date: formatDate(date),
      activeHabits: active,
      failures: failures,
      skips: <String>[],
      successes: <String>[],
    );
    current.days.add(day);
    await _dao.update(current);
  }
}
