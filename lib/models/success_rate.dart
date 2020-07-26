import 'package:habitflow/models/day.dart';

/// Returns success rates of [days].
double calculateSuccessRate(List<Day> days) {
  int total = 0;
  int successes = 0;
  print(days);
  for (final Day day in days) {
    total += day.activeHabits.length;
    successes += day.successes.length + day.skips.length;
  }
  return successes / total;
}
