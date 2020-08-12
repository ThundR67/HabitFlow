/// A service to manage user's rewards.

import 'dart:async';

import 'package:hive/hive.dart';

import 'package:habitflow/models/reward.dart';
import 'package:habitflow/services/database/database.dart';

/// Name of the database and store.
const String _dbName = 'rewards';

/// A DAO to manage user's reward points.
class RewardsDAO {
  Future<Box<Reward>> get _db async => DB2.instance.open<Reward>(_dbName);

  /// Adds a reward into db.
  Future<void> add(Reward reward) async => (await _db).put(reward.id, reward);

  /// Returns all rewards sorted by reward points required.
  Future<List<Reward>> all() async => (await _db).values.toList();

  /// Updates a reward in db.
  Future<void> update(Reward reward) async => add(reward);

  /// Deletes a reward from db.
  Future<void> delete(Reward reward) async => (await _db).delete(reward.id);

  /// Clears db.
  Future<void> clear() async => (await _db).clear();
}
