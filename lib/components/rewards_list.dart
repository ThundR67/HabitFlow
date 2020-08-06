import 'package:flutter/material.dart';
import 'package:habitflow/components/reward_card.dart';
import 'package:habitflow/models/reward.dart';

/// A widget to show all rewards in list.
class RewardsList extends StatelessWidget {
  /// Constructs.
  const RewardsList(this._rewards);

  /// List of reward to show.
  final List<Reward> _rewards;

  @override
  Widget build(BuildContext context) {
    if (_rewards == null) {
      return const LinearProgressIndicator();
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: _rewards.length,
      itemBuilder: (_, int index) => RewardCard(_rewards[index]),
    );
  }
}
