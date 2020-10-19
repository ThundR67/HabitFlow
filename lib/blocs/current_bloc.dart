import 'package:flutter/material.dart';
import 'package:habitflow/helpers/dates.dart';
import 'package:habitflow/helpers/logger.dart';

import 'package:habitflow/models/cycle.dart';
import 'package:habitflow/models/day.dart';
import 'package:habitflow/models/status.dart';
import 'package:habitflow/services/analytics/analytics.dart';
import 'package:habitflow/services/current_cycle/current_cycle.dart';
import 'package:habitflow/services/cycles/cycles.dart';
import 'package:habitflow/services/habits/habits.dart';
import 'package:habitflow/helpers/time.dart';
import 'package:logger/logger.dart';
import 'package:habitflow/resources/strings.dart';

/// Bloc to manage current cycle and statuses of habits.
class CurrentBloc extends ChangeNotifier {
  /// Constructs.
  CurrentBloc() {
    update();
  }

  final CurrentCycleDAO _dao = CurrentCycleDAO();
  final CyclesDAO _cyclesDAO = CyclesDAO();
  final HabitsDAO _habitsDAO = HabitsDAO();
  final Logger _log = logger('CurrentBloc');

  /// Current cycle.
  Cycle current;

  /// Statuses of all habits.
  Map<String, Status> statuses;

  /// Updates [statuses].
  void _updateStatuses() {
    final Day curDay = current.days[DateTime.now().format()];
    statuses = {for (final id in curDay.activeHabits) id: curDay.status(id)};
    _log.i('Statuses updated');
  }

  /// Creates a cycle.
  Future<Cycle> _create() async {
    final DateTime date = DateTime.now();

    /// Creating [Day] for current day.
    final Day day = Day(
      date: date.format(),
      activeHabits: await _habitsDAO.active(date),
    );

    /// Creating a cycle.
    final Cycle cycle = Cycle(
      start: date.format(),
      end: date.add(const Duration(days: 14)).format(),
      days: {day.date: day},
    );

    Analytics().logSimple('cycle_added');
    _log.i('Cycle Created');
    _log.d(cycle);
    return cycle;
  }

  /// Fills all the unmarked habits in [current.days].
  Future<void> _fillUnmarkedHabits() async {
    final List<DateTime> dates = datesList(
      current.start.date(),
      DateTime.now().subtract(const Duration(days: 1)),
    );

    for (final DateTime date in dates) {
      if (date.format() != DateTime.now().format()) {
        final Day day = current.days[date.format()];
        for (final String id in day.activeHabits) {
          if (day.status(id) == Status.unmarked) {
            day.failures[id] = unprovidedReason;
          }
        }
        current.days[date.format()] = day;
      }
    }
  }

  /// Fills all the non recorded days in [current.days].
  Future<void> _fill() async {
    final List<DateTime> dates = datesList(
      current.start.date(),
      DateTime.now(),
    );

    for (final DateTime date in dates) {
      if (!current.days.containsKey(date.format())) {
        current.days[date.format()] = Day.empty(
          date: date.format(),
          activeHabits: await _habitsDAO.active(date),
          addFailures: date.format() != DateTime.now().format(),
        );
      }
    }

    _log.i('Filled all the days');
  }

  /// Updates [statuses] and [current].
  Future<void> update() async {
    current ??= (await _dao.get()) ?? await _create();
    if (isEnded()) current = await _create();
    await _fill();
    await _fillUnmarkedHabits();
    _updateStatuses();
    notifyListeners();
    await _dao.update(current);
    _log.i('Updated statuses and current cycle');
    _log.d(current.toLog());
    _log.d(statuses);
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
    await _fill();
    current.days[date.format()].activeHabits = await _habitsDAO.active(date);
    await update();
    _log.i('Updated habits');
  }

  /// Removes history of habit with [id].
  Future<void> remove(String id) async {
    for (final day in current.days.values) {
      day.remove(id);
    }
    await update();
    _log.i('Removed habit with id = $id');
  }

  /// Marks habit with [id] as [status] on [date] with [reason].
  Future<void> mark(
    String id,
    Status status, {
    String reason,
    DateTime date,
  }) async {
    await _fill();
    date ??= DateTime.now();
    final String key = date.format();
    current.days[key].mark(id, status, reason: reason);
    await update();
    _log.i('Marks habit with id = $id as $status with $reason on $date');
  }

  /// Ends a cycle, puts in previous cycles, then creates new one.
  Future<void> end() async {
    Analytics().logSimple('cycle_ended', current.toLog());
    await _cyclesDAO.add(current);
    current = null;
    await update();
    _log.i('Ended cycle');
  }
}
