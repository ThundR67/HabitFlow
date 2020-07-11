import 'package:flutter/material.dart';
import 'package:habitflow/models/reward.dart';
import 'package:habitflow/services/rewards/rewards.dart';
import 'package:habitflow/services/reward_points/reward_points.dart';

/// A Bloc which does CRUD of rewards.
class RewardsBloc extends ChangeNotifier {
  /// Causes a update as soon as bloc is initialized.
  RewardsBloc() {
    _update();
  }

  final RewardsDAO _dao = RewardsDAO();

  /// All the rewards.
  List<Reward> rewards = <Reward>[];

  /// Updates [rewards].
  void _update() {
    _dao.all().then((List<Reward> value) {
      rewards = value;
      notifyListeners();
    });
  }

  /// Adds a reward into db.
  void add(Reward reward) => _dao.add(reward).whenComplete(_update);

  /// Updates a reward in db.
  void update(Reward reward) => _dao.update(reward).whenComplete(_update);

  /// Deletes a reward from db.
  void delete(Reward reward) => _dao.delete(reward).whenComplete(_update);

  /// Increases [amountTaken] of reward by one.
  void take(Reward reward) {
    reward.amountTaken++;
    update(reward);
  }
}
