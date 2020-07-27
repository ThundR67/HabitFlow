import 'dart:async';

import 'package:sembast/sembast.dart';
import 'package:habitflow/models/reward.dart';

import 'db.dart';

const String _storeName = 'rewards';

/// A DAO to manage user's reward points.
class RewardsDAO {
  final StoreRef<String, Map<String, dynamic>> _store =
      stringMapStoreFactory.store(_storeName);

  Future<Database> get _db async => await DB.instance.database;

  Finder _finder(String id) => Finder(filter: Filter.byKey(id));

  /// Adds a reward into db.
  Future<void> add(Reward reward) async {
    await _store.add(await _db, reward.toMap());
  }

  /// Returns all rewards sorted by reward points required.
  Future<List<Reward>> all() async {
    final Finder finder = Finder(sortOrders: <SortOrder>[SortOrder(pointsKey)]);

    final List<RecordSnapshot<String, Map<String, dynamic>>> snapshots =
        await _store.find(
      await _db,
      finder: finder,
    );

    return snapshots
        .map((RecordSnapshot<String, Map<String, dynamic>> snapshot) {
      final Reward reward = Reward.fromMap(snapshot.value);
      reward.id = snapshot.key;
      return reward;
    }).toList();
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
