import 'package:hive/hive.dart';

part 'day.g.dart';

/// A type to store one day of information.
@HiveType(typeId: 3)
class Day extends HiveObject {
  /// Constructs.
  Day({
    this.date,
    this.activeHabits,
    this.skips,
    this.successes,
    this.failures,
  }) {
    activeHabits ??= <String>[];
    successes ??= <String>[];
    skips ??= <String>[];
    failures ??= <String, String>{};
  }

  /// Date of the day formatted.
  @HiveField(0)
  String date;

  /// Active habits' ids on the day.
  @HiveField(1)
  List<String> activeHabits;

  /// Ids of habits successful on the day.
  @HiveField(2)
  List<String> successes;

  /// Ids of skips on the day.
  @HiveField(3)
  List<String> skips;

  /// Map of habit id and review of failures.
  @HiveField(4)
  Map<String, String> failures;
}
