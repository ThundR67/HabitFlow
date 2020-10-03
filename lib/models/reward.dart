import 'package:hive/hive.dart';
import 'package:random_string/random_string.dart';

part 'reward.g.dart';

/// A type to store information about a reward.
@HiveType(typeId: 0)
class Reward {
  /// Creates a reward.
  Reward({
    this.id,
    this.name,
    this.points,
    this.amountTaken = 0,
    this.iconData,
    this.colorHex,
  }) {
    id ??= randomAlphaNumeric(12);
  }

  /// Unique ID of this reward.
  @HiveField(0)
  String id;

  /// Unique name of this reward.
  @HiveField(1)
  String name;

  /// Points required to acquire this reward.
  @HiveField(2)
  int points;

  /// Amount of time this reward is acquired.
  @HiveField(3)
  int amountTaken;

  /// Hex value of color of this reward.
  @HiveField(4)
  String colorHex;

  /// Icon of this reward.
  @HiveField(5)
  Map<String, dynamic> iconData;

  /// Returns a loggable map format.
  Map<String, dynamic> toLog() {
    return {
      'id': id,
      'name': name,
      'points': points,
    };
  }
}
