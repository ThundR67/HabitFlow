import 'package:random_string/random_string.dart';

/// Key to refrence id of reward in map.
const String idKey = 'id';

/// Key to refrence name of reward in map.
const String nameKey = 'name';

/// Key to refrence points of reward in map.
const String pointsKey = 'reward_points';

/// Key to refrence amount taken of reward in map.
const String takenKey = 'amount_taken';

/// Key to refrence acolor of reward in map.
const String colorKey = 'color_hex';

/// Key to refrence icon data of reward in map.
const String iconKey = 'icon_data';

/// A type to store information about a reward.
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
  String id;

  /// Unique name of this reward.
  String name;

  /// Points required to acquire this reward.
  int points;

  /// Amount of time this reward is acquired.
  int amountTaken;

  /// Hex value of color of this reward.
  String colorHex;

  /// Icon of this reward.
  Map<String, dynamic> iconData;

  /// Converts a map to [Reward].
  Reward.fromMap(Map<String, dynamic> map) {
    id = map[idKey].toString();
    name = map[nameKey].toString();
    points = map[pointsKey] as int;
    amountTaken = map[takenKey] as int;
    colorHex = map[colorKey].toString();
    iconData = map[iconKey] as Map<String, dynamic>;
  }

  /// Converts [Reward] to map.
  Map<String, dynamic> toMap() {
    return {
      idKey: id,
      nameKey: name,
      pointsKey: points,
      takenKey: amountTaken,
      colorKey: colorHex,
      iconKey: iconData,
    };
  }
}
