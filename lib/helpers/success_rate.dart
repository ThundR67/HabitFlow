import 'package:habitflow/models/day.dart';

/// Returns success rates of [days].
double calculateSuccessRate(List<Day> days) {
  int total = 0;
  int successes = 0;
  for (final Day day in days) {
    total += day.activeHabits.length;
    successes += day.successes.length + day.skips.length;
  }
  if (successes > total) {
    return 0;
  }
  if (total == 0) {
    return 0;
  }
  return successes / total;
}

/// Returns success rate from [days] of habit with [id].
double calculateHabitSuccessRate(String id, List<Day> days) {
  int total = 0;
  int successes = 0;
  for (final Day day in days) {
    if (day.activeHabits.contains(id)) {
      total += 1;
    }
    if (day.successes.contains(id) || day.skips.contains(id)) {
      successes += 1;
    }
  }
  if (successes > total) {
    return 0;
  }
  if (total == 0) {
    return 0;
  }
  return successes / total;
}

/// Returns amount of times completed.
int calculateTimesCompleted(String id, List<Day> days) {
  int total = 0;
  for (final Day day in days) {
    if (day.successes.contains(id) || day.skips.contains(id)) {
      total += 1;
    }
  }
  return total;
}
