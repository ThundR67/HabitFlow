import 'package:flutter/material.dart';
import 'package:habitflow/helpers/analytics.dart';

import 'package:habitflow/models/reward.dart';
import 'package:habitflow/services/rewards/rewards.dart';

/// A Bloc which manages rewards.
class RewardsBloc extends ChangeNotifier {
  /// Causes a update as soon as bloc is initialized.
  RewardsBloc() {
    _update();
  }

  final RewardsDAO _dao = RewardsDAO();

  /// All the rewards.
  List<Reward> rewards;

  /// Updates [rewards].
  Future<void> _update() async {
    rewards = await _dao.all();
    notifyListeners();
  }

  /// Adds [reward] into db.
  Future<void> add(Reward reward) async {
    await _dao.add(reward);
    await _update();
    analytics.logEvent(name: 'reward_added');
  }

  /// Deletes [reward] from db.
  Future<void> delete(Reward reward) async {
    await _dao.delete(reward);
    await _update();
    analytics.logEvent(name: 'reward_deleted');
  }

  /// Increases [amountTaken] of [reward] by 1.
  Future<void> take(Reward reward) async {
    reward.amountTaken++;
    await _dao.update(reward);
    await _update();
    analytics.logEvent(name: 'reward_taken');
  }

  /// Resets [amountTaken] of all reward to 0.
  Future<void> reset() async {
    for (final Reward reward in rewards) {
      reward.amountTaken = 0;
      await _dao.update(reward);
    }
    await _update();
  }

  @override
  void dispose() {
    super.dispose();
    _dao.close();
  }
}
