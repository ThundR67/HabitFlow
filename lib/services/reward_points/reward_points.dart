/// A service to manage user's reward points.
import 'dart:async';

import 'package:sembast/sembast.dart';

import 'package:habitflow/services/database/database.dart';

/// The name of database and store.
const String _dbName = 'reward_points';

/// A DAO to manage user's reward points.
class RewardPointsDAO {
  /// Store of data.
  final StoreRef<String, int> _store = StoreRef<String, int>.main();

  /// Connection to db.
  Future<Database> get _db async => await DB.instance.database(_dbName);

  /// Returns user's current reward points from db.
  Future<int> get() async {
    return (await _store.record(_dbName).get(await _db)) ?? 0;
  }

  /// Changes reward points by [change].
  Future<void> changeBy(int change) async {
    await _store.record(_dbName).put(await _db, (await get()) + change);
  }

  /// Clears db.
  Future<void> clear() async => await _store.drop(await _db);
}
