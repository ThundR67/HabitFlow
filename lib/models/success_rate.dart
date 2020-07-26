import 'package:habitflow/models/dates.dart';
import 'package:habitflow/models/day.dart';

/// Returns success rates of [days].
double calculateSuccessRate(List<Day> days) {
  int total = 0;
  int successes = 0;
  for (final Day day in days) {
    total += day.activeHabits.length;
    successes += day.successes.length + day.skips.length;
  }
  return successes / total;
}

/// Returns [Day].
Day getDay(List<Day> days, DateTime date) {
  for (final Day day in days) {
    if (day.date == formatDate(date)) {
      return day;
    }
  }
  return null;
}
