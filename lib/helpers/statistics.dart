import 'package:habitflow/models/day.dart';
import 'package:habitflow/resources/strings.dart';

/// Class to represent statistic of [habits] over [days].
class Statistics {
  /// Amount of successes.
  int amountDone = 0;

  /// Amount of skips.
  int amountSkipped = 0;

  /// Amount of failures.
  int amountFailed = 0;

  /// Success rate.
  double successRate = 0;

  /// Skip rate.
  double skipRate = 0;

  /// Success + Skip rate;
  double totalRate = 0;

  /// Failure rate.
  double failureRate = 0;

  /// Total amount.
  int total = 0;

  int _amount(List<String> list, List<String> items) {
    if (items == null) return list.length;
    int i = 0;
    for (final String item in items) {
      if (list.contains(item)) i++;
    }
    return i;
  }

  double _rate(int amount) {
    if (total == 0) return 1;
    return amount / total;
  }

  /// Returns [Stat]
  Statistics({Map<String, Day> days, List<String> habits}) {
    for (final Day day in days.values) {
      total += _amount(day.activeHabits, habits);
      amountDone += _amount(day.successes, habits);
      amountSkipped += _amount(day.skips, habits);
      amountFailed += _amount(day.failures.keys.toList(), habits);
    }
    successRate = _rate(amountDone);
    skipRate = _rate(amountSkipped);
    failureRate = _rate(amountFailed);
    totalRate = successRate + skipRate;
    totalRate = totalRate > 1 ? 1 : totalRate;
  }
}

/// Returns all failure reasons of habits recently.
List<String> getRecentFailures(String id, List<Day> days) {
  final List<String> reasons = [];
  for (final Day day in days) {
    if (day.failures.containsKey(id)) {
      if (day.failures[id] != unprovidedReason) {
        reasons.add(day.failures[id]);
      }
    }
  }
  return reasons;
}
