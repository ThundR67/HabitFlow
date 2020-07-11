import 'package:random_string/random_string.dart';

/// Key to refrence id of reward in map.
const String idKey = 'id';

/// Key to refrence name of reward in map.
const String nameKey = 'name';

/// Key to refrence points of reward in map.
const String pointsKey = 'reward_points';

/// Key to refrence amount taken of reward in map.
const String takenKey = 'amount_taken';

/// A type to store information about a reward.
class Reward {
  /// Creates a reward.
  Reward({this.id, this.name, this.points, this.amountTaken = 0}) {
    id ??= randomAlphaNumeric(12);
  }

  /// Unique ID of this reward.
  String id;

  /// Unique name of this reward.
  final String name;

  /// Points required to acquire this reward.
  final int points;

  /// Amount of time this reward is acquired.
  int amountTaken;

  /// Converts a map to [Reward].
  static Reward fromMap(Map<String, dynamic> map) {
    return Reward(
      name: map[nameKey].toString(),
      points: int.parse(map[pointsKey].toString()),
      amountTaken: int.parse(map[takenKey].toString()),
    );
  }

  /// Converts [Reward] to map.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      idKey: id,
      nameKey: name,
      pointsKey: points,
      takenKey: amountTaken,
    };
  }
}
