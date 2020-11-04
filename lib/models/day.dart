import 'package:hive/hive.dart';

import 'package:habitflow/models/status.dart';
import 'package:habitflow/resources/strings.dart';

part 'day.g.dart';

/// A type to store one day of information.
@HiveType(typeId: 3)
class Day {
  /// Constructs.
  Day({
    this.date,
    this.activeHabits,
    this.skips,
    this.successes,
    this.failures,
  }) {
    skips ??= [];
    successes ??= [];
    failures ??= {};
  }

  /// Creates an empty day.
  Day.empty({this.date, this.activeHabits, bool addFailures}) {
    failures = {};
    if (addFailures) {
      failures = {for (final id in activeHabits) id: unprovidedReason};
    }
  }

  /// Date of the day formatted.
  @HiveField(0)
  String date;

  /// Active habits' ids on the day.
  @HiveField(1)
  List<String> activeHabits = [];

  /// Ids of habits successful on the day.
  @HiveField(2)
  List<String> successes = [];

  /// Ids of skips on the day.
  @HiveField(3)
  List<String> skips = [];

  /// Map of habit id and review of failures.
  @HiveField(4)
  Map<String, String> failures = {};

  /// Returns status of [id].
  Status status(String id) {
    if (successes.contains(id)) return Status.done;
    if (skips.contains(id)) return Status.skipped;
    if (failures.containsKey(id)) return Status.failed;
    return Status.unmarked;
  }

  /// Removes history of [id].
  void remove(String id) {
    unmark(id);
    activeHabits.remove(id);
  }

  /// Unmarks [id] as success, skip, or failure.
  void unmark(String id) {
    successes.remove(id);
    skips.remove(id);
    failures.remove(id);
  }

  /// Marks [id] as [status] with [reason].
  void mark(String id, Status status, {String reason}) {
    unmark(id);
    if (status == Status.done) successes.add(id);
    if (status == Status.skipped) skips.add(id);
    if (status == Status.failed) failures[id] = reason ?? unprovidedReason;
  }

  /// Returns a loggable map.
  Map<String, dynamic> toLog() {
    return {
      'date': date,
      'active': activeHabits,
      'skips': skips,
      'successes': successes,
      'failures': failures,
    };
  }
}
