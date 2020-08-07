import 'package:random_string/random_string.dart';

import 'package:habitflow/helpers/date_format.dart';
import 'package:habitflow/helpers/map_parser.dart';

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
  String date;

  /// Active habits' ids on the day.
  List<String> activeHabits;

  /// Ids of habits successful on the day.
  List<String> successes;

  /// Ids of skips on the day.
  List<String> skips;

  /// Map of habit id and review of failures.
  Map<String, String> failures;

  /// Converts a map to [Day].
  Day.fromMap(Map<String, dynamic> map) {
    id = map[idKey].toString();
    date = map[dateKey].toString();
    activeHabits = list<String>(map[activeHabitsKey]);
    successes = list<String>(map[successesKey]);
    skips = list<String>(map[skipsKey]);
    failures = dynamicToMap<String>(map[failuresKey]);
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

  /// Checks if this day is at [date].
  bool isAt(DateTime date) => formatDate(date) == this.date;
}
