import 'package:habitflow/models/goal.dart';
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

/// Key for [Habit.goal].
const String goalKey = 'goal';

/// A type to store habit information.
class Habit {
  /// Constructs.
  Habit({
    this.id,
    this.name,
    this.points,
    this.colorHex,
    this.iconData,
    this.goal,
  }) {
    id ??= randomAlphaNumeric(12);
  }

  /// Unique id of the habit.
  String id;

  /// Name of the habit.
  String name;

  /// Points gained when habit is completed.
  int points;

  /// Hex color code of the habit.
  String colorHex;

  /// Goal of habit.
  Goal goal;

  /// Icon of the habit.
  Map<String, dynamic> iconData;

  /// Converts a map to [Habit].
  Habit.fromMap(Map<String, dynamic> map) {
    id = map[idKey].toString();
    name = map[nameKey].toString();
    points = map[pointsKey] as int;
    colorHex = map[colorKey].toString();
    iconData = map[iconKey] as Map<String, dynamic>;
    goal = Goal.fromMap(map[goalKey] as Map<String, dynamic>);
  }

  /// Converts [Habit] to map.
  Map<String, dynamic> toMap() {
    return {
      idKey: id,
      nameKey: name,
      pointsKey: points,
      colorKey: colorHex,
      iconKey: iconData,
      goalKey: goal.toMap()
    };
  }
}
