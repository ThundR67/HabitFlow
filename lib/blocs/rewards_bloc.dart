import 'package:flutter/material.dart';

import 'package:logger/logger.dart';

import 'package:habitflow/helpers/logger.dart';
import 'package:habitflow/models/reward.dart';
import 'package:habitflow/services/analytics/analytics.dart';
import 'package:habitflow/services/rewards/rewards.dart';

/// A Bloc which manages rewards.
class RewardsBloc extends ChangeNotifier {
  /// Causes a update as soon as bloc is initialized.
  RewardsBloc() {
    _update();
  }

  /// All the rewards.
  List<Reward> rewards;
  final RewardsDAO _dao = RewardsDAO();
  final Logger _log = logger('RewardsBloc');

  /// Updates [rewards].
  Future<void> _update() async {
    rewards = await _dao.all();
    _log.i('Updated Rewards');
    for (final reward in rewards) {
      _log.d(reward.toLog());
    }
    notifyListeners();
  }

  /// Adds [reward] into db.
  Future<void> add(Reward reward) async {
    _log.i('Added reward: ${reward.toLog()}');
    await _dao.add(reward);
    await _update();
    Analytics().logReward('reward_added', reward);
  }

  /// Deletes [reward] from db.
  Future<void> delete(Reward reward) async {
    _log.i('Deleted reward: ${reward.toLog()}');
    await _dao.delete(reward);
    await _update();
    Analytics().logReward('reward_deleted', reward);
  }

  /// Increases [amountTaken] of [reward] by 1.
  Future<void> take(Reward reward) async {
    _log.i('Took reward: ${reward.toLog()}');
    reward.amountTaken++;
    await _dao.update(reward);
    await _update();
    Analytics().logReward('reward_taken', reward);
  }

  /// Resets [amountTaken] of all reward to 0.
  Future<void> reset() async {
    _log.i('Reset all rewards');
    for (final Reward reward in rewards) {
      reward.amountTaken = 0;
      await _dao.update(reward);
    }
    await _update();
  }
}
