import 'package:flutter/material.dart';

import 'package:habitflow/models/cycle.dart';
import 'package:habitflow/models/dates.dart';
import 'package:habitflow/models/day.dart';
import 'package:habitflow/models/habit.dart';
import 'package:habitflow/models/status.dart';
import 'package:habitflow/services/current_cycle/current_cycle.dart';
import 'package:habitflow/services/habits/habits.dart';

/// Bloc to manage current cycle
class CurrentCycleBloc extends ChangeNotifier {
  /// Constructs.
  CurrentCycleBloc() {
    update();
  }

  final CurrentCycleDAO _dao = CurrentCycleDAO();
  final HabitsDAO _habitsDAO = HabitsDAO();

  /// Current cycle.
  Cycle current = Cycle(start: '00-00-00', end: '00-00-00');

  /// Statuses of all habits.
  List<Status> statuses;

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

  /// Returns status of habit with [id].
  Status _getStatus(String id) {
    final int index = _getDayIndex(DateTime.now());
    if (current.days[index].successes.contains(id)) {
      return Status.done;
    } else if (current.days[index].skips.contains(id)) {
      return Status.skipped;
    } else if (current.days[index].failures.containsKey(id)) {
      return Status.failed;
    }
    return Status.unmarked;
  }

  /// Updates [cycle].
  Future<void> update() async {
    current = await _dao.get();
    if (current == null) {
      final DateTime start = DateTime.now();
      final DateTime end = start.add(const Duration(days: 14));
      current = Cycle(start: formatDate(start), end: formatDate(end));
      await _dao.create(current);
    }
    await _fill();
    final List<Habit> habits = await _habitsDAO.all();
    statuses = <Status>[];
    for (final Habit habit in habits) {
      statuses.add(_getStatus(habit.id));
    }
    notifyListeners();
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
    await update();
  }

  /// Marks habit as done on [date].
  Future<void> done(String id, [DateTime date]) async {
    await unmark(id, date);
    final int index = _getDayIndex(date ?? DateTime.now());
    current.days[index].successes.add(id);
    await _dao.update(current);
    await update();
  }

  /// Marks habit as skipped on [date].
  Future<void> skip(String id, [DateTime date]) async {
    await unmark(id, date);
    final int index = _getDayIndex(date ?? DateTime.now());
    current.days[index].skips.add(id);
    await _dao.update(current);
    await update();
  }

  /// Marks habit as failed on [date].
  Future<void> fail(String id, String reason, [DateTime date]) async {
    await unmark(id, date);
    final int index = _getDayIndex(date ?? DateTime.now());
    current.days[index].failures[id] = reason;
    await _dao.update(current);
    await update();
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
    final bool isToday = formatDate(date) == formatDate(DateTime.now());
    if (_contains(date) && !isToday) {
      return;
    } else if (_contains(date) && isToday) {
      current.days[_getDayIndex(DateTime.now())].activeHabits =
          await _habitsDAO.active(DateTime.now());
      await _dao.update(current);
      return;
    }

    final List<String> active = await _habitsDAO.active(date);
    Map<String, String> failures = <String, String>{
      for (String e in active) e: ''
    };
    if (isToday) {
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
