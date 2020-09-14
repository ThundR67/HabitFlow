import 'package:habitflow/resources/strings.dart';
import 'package:hive/hive.dart';

import 'package:habitflow/models/day.dart';

part 'cycle.g.dart';

/// TODO add a map of habits in each cycle class. so if habit gets deleted
/// its name is still preserved for past cycles.

/// A type to store cycle's information.
@HiveType(typeId: 4)
class Cycle {
  /// Constructs.
  Cycle({
    this.start,
    this.end,
    this.review,
    this.days,
  }) {
    days ??= <String, Day>{};
    review ??= unprovidedReason;
  }

  /// Day when cycle started.
  @HiveField(0)
  String start;

  /// Day when cycle ended.
  @HiveField(1)
  String end;

  /// Review of the cycle by user
  @HiveField(2)
  String review;

  /// Information of each day.
  @HiveField(3)
  Map<String, Day> days;
}
