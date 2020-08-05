import 'package:habitflow/helpers/date_format.dart';
import 'package:habitflow/helpers/dates.dart';
import 'package:habitflow/models/day.dart';
import 'package:habitflow/models/status.dart';
import 'package:habitflow/services/habits/habits.dart';

/// A class to manage days of a cycle
class Days {
  /// Constructs.
  Days(this.days);

  /// All the days.
  Map<String, Day> days;

  /// Deletes history of habit with [id].
  void deleteHistory(String id) {
    for (final Day day in days.values) {
      days[day.date].activeHabits.remove(id);
      unmark(id, parseDate(day.date));
    }
  }

  /// Returns status of habit with [id] at [date].
  Status status(String id, [DateTime date]) {
    final String key = formatDate(date ?? DateTime.now());
    if (days[key].successes.contains(id)) {
      return Status.done;
    } else if (days[key].skips.contains(id)) {
      return Status.skipped;
    } else if (days[key].failures.containsKey(id)) {
      return Status.failed;
    }
    return Status.unmarked;
  }

  /// Unmarks habit with [id] at [date].
  void unmark(String id, [DateTime date]) {
    final String key = formatDate(date ?? DateTime.now());
    days[key].successes.remove(id);
    days[key].skips.remove(id);
    days[key].failures.remove(id);
  }

  /// Marks habit with [id] as [status] at [date].
  void mark(String id, Status status, {DateTime date, String reason}) {
    unmark(id, date);
    final String key = formatDate(date ?? DateTime.now());
    if (status == Status.done) {
      days[key].successes.add(id);
    } else if (status == Status.skipped) {
      days[key].skips.add(id);
    } else if (status == Status.failed) {
      days[key].failures[id] = reason;
    }
  }

  /// Marks all habit that are unmarked as [Status.failed] on [date].
  void _failUnmarked(DateTime date) {
    final Day day = days[formatDate(date)];
    if (day.date != formatDate(DateTime.now())) {
      for (final String id in day.activeHabits) {
        if (status(id, parseDate(day.date)) == Status.unmarked) {
          days[day.date].failures[id] = 'NOT PROVIDED';
        }
      }
    }
  }

  /// Fills [date] with blank data.
  Future<void> _fillDate(DateTime date, HabitsDAO dao) async {
    final String key = formatDate(date);
    if (days[key] == null) {
      final List<String> ids = await dao.active(date);
      final Map<String, String> failures = <String, String>{
        for (String id in ids) id: 'NOT PROVIDED'
      };
      final Day day = Day(
        activeHabits: ids,
        failures: key == formatDate(DateTime.now()) ? null : failures,
      );
      days[key] = day;
    }
  }

  /// Fills all missing days.
  Future<void> fill(DateTime start, DateTime end, HabitsDAO dao) async {
    if (formatDate(start) == formatDate(DateTime.now())) {
      await _fillDate(DateTime.now(), dao);
      return;
    }

    final List<DateTime> dates = datesList(start, end);
    for (final DateTime date in dates) {
      await _fillDate(date, dao);
      _failUnmarked(date);
    }
  }
}
