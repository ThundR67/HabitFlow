import 'package:flutter/material.dart';
import 'package:habitflow/models/dates.dart';

import 'package:habitflow/models/day.dart';
import 'package:habitflow/services/days/days.dart';
import 'package:habitflow/services/habits/dao.dart';

/// A bloc to manage days information.
class DaysBloc extends ChangeNotifier {
  /// Causes update as constructed.
  DaysBloc() {
    /// TODO remove clear
    _dao.clear().whenComplete(_update);
  }

  final DaysDAO _dao = DaysDAO();
  final HabitsDAO _habitsDAO = HabitsDAO();

  /// All days stored in db.
  List<Day> days = <Day>[];

  /// Updates [days].
  void _update() {
    _dao.all().then((List<Day> value) {
      days = value;
      notifyListeners();
      _fill();
    });
  }

  /// Marks habit as done on [date].
  Future<void> done(String id, [DateTime date]) async {
    final Day day = await _dao.getFromDate(date ?? DateTime.now());
    day.successes.add(id);
    await _dao.update(day);
  }

  /// Marks habit as skipped on [date].
  Future<void> skip(String id, [DateTime date]) async {
    final Day day = await _dao.getFromDate(date ?? DateTime.now());
    day.skips.add(id);
    await _dao.update(day);
  }

  /// Marks habit as failed on [date].
  Future<void> fail(String id, String reason, [DateTime date]) async {
    final Day day = await _dao.getFromDate(date ?? DateTime.now());
    day.failures[id] = reason;
    await _dao.update(day);
  }

  /// Fills all the days that werent recorded.
  /// Wont fill in if last day was more than 15 days old.
  Future<void> _fill() async {
    final DateTime lastDate = Day.parse(days[0].date);
    final int difference = DateTime.now().difference(lastDate).inDays;
    if (difference > 15) {
      return;
    }

    final List<DateTime> dates = getDates(
      DateTime.now().subtract(const Duration(days: 1)),
      lastDate,
    );
    for (final DateTime date in dates) {
      final List<String> activeHabits = await _habitsDAO.active(date);
      final Day day = Day(
        date: Day.format(date),
        activeHabits: activeHabits,
        failures: <String, String>{for (String e in activeHabits) e: ''},
        skips: <String>[],
        successes: <String>[],
      );
      _dao.add(day);
    }
  }
}
