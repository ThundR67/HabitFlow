import 'dart:async';

import 'package:sembast/sembast.dart';

import 'db.dart';

const String _pointsRecord = 'reward_points';

/// A DAO to manage user's reward points.
class RewardPointsDAO {
  final StoreRef<String, int> _store = StoreRef<String, int>.main();

  Future<Database> get _db async => await DB.instance.database;

  /// Returns user's current reward points from db.
  Future<int> rewardPoints() async {
    final int points = await _store.record(_pointsRecord).get(await _db);
    return points == null ? points : 0;
  }

  /// Increments reward points.
  Future<void> incrementPoints(int increment) async {
    int points = await rewardPoints();
    points += increment;
    await _store.record(_pointsRecord).put(await _db, points);
  }

  /// Clears db.
  Future<void> clear() async => await _store.drop(await _db);
}
