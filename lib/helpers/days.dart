import 'package:habitflow/helpers/date_format.dart';
import 'package:habitflow/helpers/dates.dart';
import 'package:habitflow/models/day.dart';
import 'package:habitflow/models/status.dart';
import 'package:habitflow/services/habits/habits.dart';
import 'package:habitflow/resources/strings.dart';

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
    for (final String id in day.activeHabits) {
      if (status(id, parseDate(day.date)) == Status.unmarked) {
        days[day.date].failures[id] = unprovidedReason;
      }
    }
  }

  /// Fills [date] with blank data.
  Future<void> _fillDate(DateTime date, HabitsDAO dao) async {
    final String key = formatDate(date);
    if (days[key] == null) {
      final List<String> ids = await dao.active(date);
      final Day day = Day(
        date: formatDate(date),
        activeHabits: ids,
      );
      days[key] = day;
    }
  }

  /// Fills all missing days.
  Future<void> fill(DateTime start, DateTime end, HabitsDAO dao) async {
    final List<DateTime> dates = datesList(start, DateTime.now());
    for (final DateTime date in dates) {
      await _fillDate(date, dao);
      if (formatDate(date) != formatDate(DateTime.now())) _failUnmarked(date);
    }
  }
}
