import 'package:flutter/material.dart';

import 'package:habitflow/models/cycle.dart';
import 'package:habitflow/models/dates.dart';
import 'package:habitflow/models/day.dart';
import 'package:habitflow/models/success_rate.dart';
import 'package:habitflow/services/cycles/cycles.dart';
import 'package:habitflow/services/days/dao.dart';
import 'package:habitflow/services/habits/dao.dart';

/// Bloc to manage cycles
class CyclesBloc extends ChangeNotifier {
  /// Constructs.
  CyclesBloc() {
    _dao.clear().whenComplete(_update);
  }

  final CyclesDAO _dao = CyclesDAO();
  final DaysDAO _daysDAO = DaysDAO();
  final HabitsDAO _habitsDAO = HabitsDAO();

  /// All the cycles.
  Map<String, Cycle> cycles = <String, Cycle>{};

  /// Current cycle.
  Cycle current = Cycle(start: '00-00-00', end: '00-00-00');

  /// Current cycle succes rate.
  double currentSuccessRate = 0;

  /// Updates [cycle].
  Future<void> _update() async {
    cycles = await _dao.all();
    if (!isRunning()) {
      await start();
      await _update();
    }
    current = cycles.values.toList()[0];
    currentSuccessRate = await _currentSuccessRate();
    notifyListeners();
  }

  /// Returns whether a cycle is currently running.
  bool isRunning() {
    if (cycles.isEmpty) {
      return false;
    }
    return parseDate(cycles.values.toList()[0].end).isAfter(DateTime.now());
  }

  /// Starts a cycle.
  Future<void> start() async {
    final DateTime start = DateTime.now();
    final Cycle cycle = Cycle(
      start: formatDate(start),
      end: formatDate(start.add(const Duration(days: 15))),
    );
    await _dao.add(cycle);
    await _update();
  }

  /// Returns a default day with all failures.
  Future<Day> _filler(DateTime date) async {
    final List<String> activeHabits = await _habitsDAO.active(date);
    Map<String, String> failures = <String, String>{
      for (String e in activeHabits) e: ''
    };
    if (formatDate(date) == formatDate(DateTime.now())) {
      failures = <String, String>{};
    }

    return Day(
      date: formatDate(date),
      activeHabits: activeHabits,
      failures: failures,
      skips: <String>[],
      successes: <String>[],
    );
  }

  /// Returns success rate of current cycle.
  Future<double> _currentSuccessRate() async {
    final List<Day> days = <Day>[];
    final List<DateTime> dates = getDates(
      parseDate(current.start),
      parseDate(current.end),
    );
    final Map<String, Day> allDays = await _daysDAO.all();
    for (final DateTime date in dates) {
      Day toAdd = allDays[formatDate(date)];
      toAdd ??= await _filler(date);
      days.add(toAdd);
    }
    return calculateSuccessRate(days);
  }

  /// Returns succes rate of cycle with [id]
  double successRate(String id) {
    return calculateSuccessRate(cycles[id].days);
  }

  /// Ends a cycle.
  Future<void> end(String review) async {
    final Cycle cycle = cycles[0];
    final List<DateTime> dates = getDates(
      parseDate(cycle.start),
      parseDate(cycle.end),
    );
    cycle.review = review;

    final Map<String, Day> days = await _daysDAO.all();
    for (final DateTime date in dates) {
      cycle.days.add(days[formatDate(date)]);
    }

    await _dao.update(cycle);
    await _update();
  }
}
