import 'package:flutter/material.dart';

import 'package:habitflow/helpers/date_format.dart';
import 'package:habitflow/helpers/days.dart';
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
    _update();
  }

  final CurrentCycleDAO _dao = CurrentCycleDAO();
  final CyclesDAO _cyclesDAO = CyclesDAO();
  final HabitsDAO _habitsDAO = HabitsDAO();

  /// Helper for days of cycle.
  Days _days;

  /// Current cycle.
  Cycle current;

  /// Statuses of all habits.
  Map<String, Status> statuses;

  /// Updates [statuses] and [current].
  Future<void> _update() async {
    /// Loads up current cycle if not loaded.
    if (current == null) {
      current = await _dao.get();
      if (current == null) await create();
    }

    /// If [current] has ended then stop and notify listeners.
    if (isEnded()) {
      notifyListeners();
      return;
    }

    // Fills missing days and unmarked failures.
    _days = Days(current.days);
    await _days.fill(
      Time.parse(current.start),
      Time.parse(current.end),
      _habitsDAO,
    );
    current.days = _days.days;

    /// Updates. [statuses] and notify listeners.
    _updateStatuses();
    notifyListeners();

    /// Updates [current] in the db.
    await _dao.update(current);
  }

  /// Updates [statuses].
  void _updateStatuses() {
    final String key = DateTime.now().format();
    statuses = {
      for (final String id in current.days[key].activeHabits)
        id: _days.status(id)
    };
  }

  /// Updates current day's active habits.
  Future<void> updateActiveHabits() async {
    final DateTime date = DateTime.now();
    current.days[date.format()].activeHabits = await _habitsDAO.active(date);
    await _update();
  }

  /// Deletes history of habit with [id].
  Future<void> deleteHistory(String id) async {
    _days.deleteHistory(id);
    await _update();
  }

  /// Marks habit with [id] as [status] on [date].
  Future<void> mark(
    String id,
    Status status, [
    String reason,
    DateTime date,
  ]) async {
    _days.mark(
      id,
      status,
      reason: reason,
      date: date ?? DateTime.now(),
    );
    await _update();
  }

  /// Updates [current]  to a new cycle.
  Future<void> create() async {
    final DateTime date = DateTime.now();

    /// Creating [Day] for current day.
    final Day day = Day(
      date: date.format(),
      activeHabits: await _habitsDAO.active(date),
    );

    /// Creating a cycle.
    current = Cycle(
      start: date.format(),
      end: date.add(const Duration(days: 15)).format(),
      days: {day.date: day},
    );

    await _update();
    Analytics().logSimple('cycle_added');
  }

  /// Ends a cycle, puts in previous cycles, then creates new one.
  Future<void> end() async {
    await _cyclesDAO.add(current);
    await create();
    Analytics().logSimple('cycle_ended');
  }

  /// Returns if [current] ended.
  bool isEnded() => DateTime.now().isAfter(Time.parse(current.end));

  @override
  void dispose() {
    super.dispose();
    _cyclesDAO.close();
    _dao.close();
    _habitsDAO.close();
  }
}
