import 'package:habitflow/models/goal.dart';
import 'package:hive/hive.dart';
import 'package:random_string/random_string.dart';

part 'habit.g.dart';

/// A type to store habit information.
@HiveType(typeId: 1)
class Habit extends HiveObject {
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
  @HiveField(0)
  String id;

  /// Name of the habit.
  @HiveField(1)
  String name;

  /// Points gained when habit is completed.
  @HiveField(2)
  int points;

  /// Hex color code of the habit.
  @HiveField(3)
  String colorHex;

  /// Goal of habit.
  @HiveField(4)
  Goal goal;

  /// Icon of the habit.
  @HiveField(5)
  Map<String, dynamic> iconData;
}
