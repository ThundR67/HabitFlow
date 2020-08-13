/// A service to manage user's reward points.

import 'dart:async';

import 'package:hive/hive.dart';

/// The name of database and store.
const String _dbName = 'reward_points';

/// A DAO to manage user's reward points.
class RewardPointsDAO {
  Future<Box<int>> get _db async => Hive.openBox(_dbName);

  /// Returns user's current reward points from db.
  Future<int> get() async => (await _db).get(_dbName, defaultValue: 0);

  /// Changes reward points by [change].
  Future<void> changeBy(int change) async {
    final int current = await get();
    await (await _db).put(_dbName, current + change);
  }

  /// Closes connection to db.
  Future<void> close() async => (await _db).close();

  /// Clears db.
  Future<void> clear() async => (await _db).clear();
}
