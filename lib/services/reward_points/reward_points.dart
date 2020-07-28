import 'dart:async';

import 'package:sembast/sembast.dart';

import 'db.dart';

const String _pointsRecord = 'reward_points';

/// A DAO to manage user's reward points.
class RewardPointsDAO {
  final StoreRef<String, int> _store = StoreRef<String, int>.main();

  Future<Database> get _db async => await DB.instance.database;

  /// Returns user's current reward points from db.
  Future<int> get() async {
    final int points = await _store.record(_pointsRecord).get(await _db);
    return points ?? 0;
  }

  /// Changes reward points by [change].
  Future<void> changeBy(int change) async {
    int points = await get();
    points += change;
    await _store.record(_pointsRecord).put(await _db, points);
  }

  /// Clears db.
  Future<void> clear() async => await _store.drop(await _db);
}
