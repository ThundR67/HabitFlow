/// A service to manage user's reward points.

import 'dart:async';

import 'package:hive/hive.dart';
import 'package:sembast/sembast.dart';

import 'package:habitflow/services/database/database.dart';

/// The name of database and store.
const String _dbName = 'reward_points';

/// A DAO to manage user's reward points.
class RewardPointsDAO {
  /// Connection to db.
  Future<Box> get _db => openDatabase(_dbName);

  /// Returns user's current reward points from db.
  Future<int> get() async {
    return (await _db).get(_dbName, defaultValue: 0) as int;
  }

  /// Changes reward points by [change].
  Future<void> changeBy(int change) async {
    final int current = await get();
    await (await _db).put(_dbName, current + change);
  }

  /// Clears db.
  Future<void> clear() async => (await _db).clear();
}
