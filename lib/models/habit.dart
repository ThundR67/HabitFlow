import 'package:random_string/random_string.dart';

/// Key to refrence id of habit in map.
const String idKey = 'id';

/// Key to refrence name of habit in map.
const String nameKey = 'name';

/// Key to refrence points of habit in map.
const String pointsKey = 'habit_points';

/// Key to refrence acolor of habit in map.
const String colorKey = 'color_hex';

/// Key to refrence icon data of habit in map.
const String iconKey = 'icon_data';

/// Key for [Habit.activeDays].
const String activeDaysKey = 'active_days';

/// A type to store habit information.
class Habit {
  /// Constructs.
  Habit({
    this.id,
    this.name,
    this.points,
    this.colorHex,
    this.iconData,
    this.activeDays,
  }) {
    id ??= randomAlphaNumeric(12);
  }

  /// Unique id of the habit.
  String id;

  /// Name of the habit.
  final String name;

  /// Points gained when habit is completed.
  final int points;

  /// Hex color code of the habit.
  final String colorHex;

  /// Weekdays the habit is active on.
  final List<int> activeDays;

  /// Icon of the habit.
  final Map<String, dynamic> iconData;

  /// Converts a map to [Habit].
  static Habit fromMap(Map<String, dynamic> map) {
    return Habit(
      id: map[idKey].toString(),
      name: map[nameKey].toString(),
      points: int.parse(map[pointsKey].toString()),
      colorHex: map[colorKey].toString(),
      iconData: map[iconKey] as Map<String, dynamic>,
      activeDays: List<int>.from(map[activeDaysKey] as Iterable<dynamic>),
    );
  }

  /// Converts [Habit] to map.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      idKey: id,
      nameKey: name,
      pointsKey: points,
      colorKey: colorHex,
      iconKey: iconData,
      activeDaysKey: activeDays,
    };
  }
}
