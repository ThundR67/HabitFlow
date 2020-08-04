import 'package:habitflow/helpers/map_parser.dart';
import 'package:random_string/random_string.dart';

import 'package:habitflow/models/day.dart';

/// Key for [Cycle.start].
const String startKey = 'start';

/// Key for [Cycle.end].
const String endKey = 'end';

/// Key for [Cycle.id].
const String idKey = 'id';

/// Key for [Cycle.review].
const String reviewKey = 'review';

/// Key for [Cycle.days]
const String daysKey = 'days';

/// A type to store cycle's information.
class Cycle {
  /// Constructs.
  Cycle({
    this.id,
    this.start,
    this.end,
    this.review,
    this.days,
  }) {
    id ??= randomAlpha(12);
    days ??= <String, Day>{};
    review ??= 'NOT PROVIDED';
  }

  /// ID of the cycle.
  String id;

  /// Day when cycle started.
  final String start;

  /// Day when cycle ended.
  final String end;

  /// Review of the cycle by user
  String review;

  /// Information of each day.
  Map<String, Day> days;

  /// Converts map to [Cycle].
  static Cycle fromMap(Map<String, dynamic> map) {
    return Cycle(
      id: map[idKey].toString(),
      start: map[startKey].toString(),
      end: map[endKey].toString(),
      review: map[reviewKey].toString(),
      days: dynamicToMap<Day>(map[daysKey]),
    );
  }

  /// Converts [Cycle] to map.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      idKey: id,
      startKey: start,
      endKey: end,
      reviewKey: review,
      daysKey: days,
    };
  }
}
