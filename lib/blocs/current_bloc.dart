import 'dart:io';

import 'package:flutter/material.dart';
import 'package:habitflow/helpers/dates.dart';

import 'package:habitflow/models/cycle.dart';
import 'package:habitflow/models/day.dart';
import 'package:habitflow/models/status.dart';
import 'package:habitflow/services/analytics/analytics.dart';
import 'package:habitflow/services/current_cycle/current_cycle.dart';
import 'package:habitflow/services/cycles/cycles.dart';
import 'package:habitflow/services/habits/habits.dart';
import 'package:habitflow/helpers/time.dart';

/// Bloc to manage current cycle and statuses of habits.
class CurrentBloc extends ChangeNotifier {
  /// Constructs.
  CurrentBloc() {
    update();
  }

  final CurrentCycleDAO _dao = CurrentCycleDAO();
  final CyclesDAO _cyclesDAO = CyclesDAO();
  final HabitsDAO _habitsDAO = HabitsDAO();

  /// Current cycle.
  Cycle current;

  /// Statuses of all habits.
  Map<String, Status> statuses;

  /// Updates [statuses].
  void _updateStatuses() {
    final Day curDay = current.days[DateTime.now().format()];
    statuses = {for (final id in curDay.activeHabits) id: curDay.status(id)};
  }

  /// Creates a cycle.
  Future<Cycle> _create() async {
    Analytics().logSimple('cycle_added');
    final DateTime date = DateTime.now();

    /// Creating [Day] for current day.
    final Day day = Day(
      date: date.format(),
      activeHabits: await _habitsDAO.active(date),
    );

    /// Creating a cycle.
    return Cycle(
      start: date.format(),
      end: date.add(const Duration(days: 14)).format(),
      days: {day.date: day},
    );
  }

  /// Fills all the [current.days].
  Future<void> _fill() async {
    final List<DateTime> dates = datesList(
      current.start.date(),
      current.end.date(),
    );

    for (final DateTime date in dates) {
      current.days[date.format()] ??= Day.empty(
        date: date.format(),
        activeHabits: await _habitsDAO.active(date),
        addFailures: true,
      );
    }
  }

  /// Updates [statuses] and [current].
  Future<void> update() async {
    current ??= (await _dao.get()) ?? await _create();
    if (isEnded()) current = await _create();
    await _fill();
    _updateStatuses();
    notifyListeners();
    await _dao.update(current);
  }

  /// Returns if [current] has ended and current day is over.
  bool isEnded() {
    final bool isAfter = DateTime.now().isAfter(current.end.date());
    final bool isDayOver = DateTime.now().day > current.end.date().day;
    return isAfter && isDayOver;
  }

  /// Updates current day's active habits.
  Future<void> updateHabits() async {
    final DateTime date = DateTime.now();
    current.days[date.format()].activeHabits = await _habitsDAO.active(date);
    await update();
  }

  /// Removes history of habit with [id].
  Future<void> remove(String id) async {
    for (final day in current.days.values) {
      day.remove(id);
    }
    await update();
  }

  /// Marks habit with [id] as [status] on [date] with [reason].
  Future<void> mark(
    String id,
    Status status, {
    String reason,
    DateTime date,
  }) async {
    final String key = (date ?? DateTime.now()).format();
    current.days[key].mark(id, status, reason: reason);
    await update();
  }

  /// Ends a cycle, puts in previous cycles, then creates new one.
  Future<void> end() async {
    Analytics().logSimple('cycle_ended');
    await _cyclesDAO.add(current);
    current = null;
    await update();
  }
}
