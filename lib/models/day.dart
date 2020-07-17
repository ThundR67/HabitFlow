import 'package:intl/intl.dart';

//// Formatter to format dates.
final DateFormat formatter = DateFormat('yyyy-MM-dd');

/// Key of [Day.id].
const String idKey = 'id';

/// Key of [Day.date].
const String dateKey = 'date';

/// Key of [Day.activeHabits].
const String activeHabitsKey = 'active_habits';

/// Key of [Day.skips].
const String skipsKey = 'skips';

/// Key of [Day.successes].
const String successesKey = 'successes';

/// Key of [Day.failures].
const String failuresKey = 'failures';

/// A type to store one day of information.
class Day {
  /// Constructs.
  Day({
    this.date,
    this.activeHabits,
    this.skips,
    this.successes,
    this.failures,
  });

  /// Id of the day.
  String id;

  /// Date of the day formatted.
  final String date;

  /// Active habits' ids on the day.
  final List<String> activeHabits;

  /// Ids of habits successful on the day.
  final List<String> successes;

  /// Ids of skips on the day.
  final List<String> skips;

  /// Map of habit id and review of failures.
  final Map<String, String> failures;

  /// Formates a [DateTime] into [String].
  static String format(DateTime date) => formatter.format(date);

  /// Parses [String] into [Datetime].
  static DateTime parse(String str) => formatter.parse(str);

  /// Converts a map to [Day].
  static Day fromMap(Map<String, dynamic> map) {
    return Day(
      date: map[dateKey].toString(),
      activeHabits: map[activeHabitsKey] as List<String>,
      successes: map[successesKey] as List<String>,
      skips: map[skipsKey] as List<String>,
      failures: map[failuresKey] as Map<String, String>,
    );
  }

  /// Converts [Day] into map.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      idKey: id,
      dateKey: date,
      activeHabitsKey: activeHabits,
      successesKey: successes,
      skipsKey: skips,
      failuresKey: failuresKey,
    };
  }

  /// Checks if this day is [date].
  bool isDay(DateTime date) => format(date) == this.date;
}
