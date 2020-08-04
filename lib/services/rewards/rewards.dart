/// Manages user's rewards.
import 'dart:async';

import 'package:sembast/sembast.dart';

import 'package:habitflow/models/reward.dart';
import 'package:habitflow/services/database/database.dart';

/// Name of the database and store.
const String _dbName = 'rewards';

/// A DAO to manage user's reward points.
class RewardsDAO {
  /// The store where data is stored.
  final StoreRef<String, Map<String, dynamic>> _store =
      stringMapStoreFactory.store(_dbName);

  /// Connection to the DB.
  Future<Database> get _db async => await DB.instance.database(_dbName);

  /// Creates a finder with filter of [id].
  Finder _finder(String id) => Finder(filter: Filter.byKey(id));

  /// Adds a reward into db.
  Future<void> add(Reward reward) async {
    await _store.add(await _db, reward.toMap());
  }

  /// Returns all rewards sorted by reward points required.
  Future<List<Reward>> all() async {
    final List<RecordSnapshot<String, Map<String, dynamic>>> snapshots =
        await _store.find(
      await _db,
      finder: Finder(sortOrders: <SortOrder>[SortOrder(pointsKey)]),
    );

    return snapshots.map(
      (RecordSnapshot<String, Map<String, dynamic>> snapshot) {
        return Reward.fromMap(snapshot.value);
      },
    ).toList();
  }

  /// Updates a reward in db.
  Future<void> update(Reward reward) async {
    await _store.update(
      await _db,
      reward.toMap(),
      finder: _finder(reward.id),
    );
  }

  /// Deletes a reward from db.
  Future<void> delete(Reward reward) async {
    await _store.delete(await _db, finder: _finder(reward.id));
  }

  /// Clears db.
  Future<void> clear() async => await _store.drop(await _db);
}
