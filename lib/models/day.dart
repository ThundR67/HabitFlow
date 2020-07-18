import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';

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
    this.id,
    this.date,
    this.activeHabits,
    this.skips,
    this.successes,
    this.failures,
  }) {
    id ??= randomAlphaNumeric(12);
    activeHabits ??= <String>[];
    successes ??= <String>[];
    skips ??= <String>[];
    failures ??= <String, String>{};
  }

  /// Id of the day.
  String id;

  /// Date of the day formatted.
  final String date;

  /// Active habits' ids on the day.
  List<String> activeHabits = <String>[];

  /// Ids of habits successful on the day.
  List<String> successes = <String>[];

  /// Ids of skips on the day.
  List<String> skips = <String>[];

  /// Map of habit id and review of failures.
  Map<String, String> failures = <String, String>{};

  /// Formates a [DateTime] into [String].
  static String format(DateTime date) => formatter.format(date);

  /// Parses [String] into [Datetime].
  static DateTime parse(String str) => formatter.parse(str);

  /// Converts a map to [Day].
  static Day fromMap(Map<String, dynamic> map) {
    return Day(
      id: map[idKey].toString(),
      date: map[dateKey].toString(),
      activeHabits:
          List<String>.from(map[activeHabitsKey] as Iterable<dynamic>),
      successes: List<String>.from(map[successesKey] as Iterable<dynamic>),
      skips: List<String>.from(map[skipsKey] as Iterable<dynamic>),
      failures:
          Map<String, String>.from(map[failuresKey] as Map<String, dynamic>),
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
      failuresKey: failures,
    };
  }

  /// Checks if this day is [date].
  bool isDay(DateTime date) => format(date) == this.date;
}
