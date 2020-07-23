import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

import 'package:habitflow/models/habit.dart';
import 'package:habitflow/models/day.dart';
import 'package:habitflow/models/dates.dart';
import 'package:habitflow/models/status.dart';
import 'package:habitflow/services/habits/habits.dart';
import 'package:habitflow/services/days/days.dart';

/// A Bloc which does CRUD of habits.
class HabitsBloc extends ChangeNotifier {
  /// Causes a update as soon as bloc is initialized.
  HabitsBloc() {
    /// TODO remove
    _daysDao.clear();
    _dao.clear().whenComplete(() {
      final Habit data = Habit(
        name: 'Gaming 20 mins',
        points: 30,
        colorHex: '#00e676',
        iconData: iconDataToMap(Icons.gamepad),
        activeDays: <int>[1, 2, 3, 4, 5, 6, 7],
      );
      _dao.add(data).whenComplete(_update);
    });
  }

  final HabitsDAO _dao = HabitsDAO();
  final DaysDAO _daysDao = DaysDAO();

  /// All the habits.
  List<Habit> habits = <Habit>[];

  /// All the statuses of habits.
  List<Status> statuses = <Status>[];

  /// All the days.
  List<Day> days = <Day>[];

  /// Updates [habits].
  Future<void> _update() async {
    await _fillDay(DateTime.now());
    _dao.all().then((List<Habit> value) async {
      habits = value;
      statuses = <Status>[];
      for (final Habit habit in value) {
        statuses.add(await status(habit.id));
      }
      notifyListeners();
      _fill();
    });
  }

  /// Adds a habit into db.
  void add(Habit habit) => _dao.add(habit).whenComplete(_update);

  /// Updates a habit in db.
  void update(Habit habit) => _dao.update(habit).whenComplete(_update);

  /// Deletes a habit from db.
  void delete(Habit habit) => _dao.delete(habit).whenComplete(_update);

  /// Returns status of habit on [date].
  Future<Status> status(String id, [DateTime date]) async {
    final Day day = await _daysDao.getFromDate(date ?? DateTime.now());
    if (day.successes.contains(id)) {
      return Status.done;
    }
    if (day.skips.contains(id)) {
      return Status.skipped;
    }
    if (day.failures.containsKey(id)) {
      return Status.failed;
    }
    return Status.unmarked;
  }

  /// Unmarks a habit as nothing on [date].
  Future<void> unmark(String id, [DateTime date]) async {
    final Day day = await _daysDao.getFromDate(date ?? DateTime.now());
    day.successes.remove(id);
    day.skips.remove(id);
    day.failures.remove(id);
    await _daysDao.update(day);
  }

  /// Unmarks a habit as nothing on [date] and updates.
  Future<void> undo(String id, [DateTime date]) async {
    await unmark(id, date);
    await _update();
  }

  /// Marks habit as done on [date].
  Future<void> done(String id, [DateTime date]) async {
    await unmark(id, date);
    final Day day = await _daysDao.getFromDate(date ?? DateTime.now());
    day.successes.add(id);
    await _daysDao.update(day);
    await _update();
  }

  /// Marks habit as skipped on [date].
  Future<void> skip(String id, [DateTime date]) async {
    await unmark(id, date);
    final Day day = await _daysDao.getFromDate(date ?? DateTime.now());
    day.skips.add(id);
    await _daysDao.update(day);
    await _update();
  }

  /// Marks habit as failed on [date].
  Future<void> fail(String id, String reason, [DateTime date]) async {
    await unmark(id, date);
    final Day day = await _daysDao.getFromDate(date ?? DateTime.now());
    day.failures[id] = reason;
    await _daysDao.update(day);
    await _update();
  }

  /// Fills a day if it does not exists.
  Future<void> _fillDay(DateTime date) async {
    if ((await _daysDao.getFromDate(date)) != null) {
      return; // Returns if info about [date] exists.
    }

    final List<String> activeHabits = await _dao.active(date);
    Map<String, String> failures = <String, String>{
      for (String e in activeHabits) e: ''
    };
    if (Day.format(date) == Day.format(DateTime.now())) {
      failures = <String, String>{};
    }

    final Day day = Day(
      date: Day.format(date),
      activeHabits: activeHabits,
      failures: failures,
      skips: <String>[],
      successes: <String>[],
    );
    await _daysDao.add(day);
  }

  /// Fills all the days that weren't recorded.
  /// Wont fill in if last recorded day was more than 15 days old.
  Future<void> _fill() async {
    if (days.isEmpty) {
      return;
    }
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
      await _fillDay(date);
    }
  }
}
