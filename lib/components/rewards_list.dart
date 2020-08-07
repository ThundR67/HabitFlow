import 'package:flutter/material.dart';
import 'package:habitflow/components/reward_card.dart';
import 'package:habitflow/models/reward.dart';

/// A widget to show all rewards in list.
class RewardsList extends StatelessWidget {
  /// Constructs.
  const RewardsList(this._rewards);

  /// List of reward to show.
  final List<Reward> _rewards;

  /// Creates list of RewardCard.
  List<Widget> _rewardsCards() {
    final List<Widget> output = <Widget>[];
    for (final Reward reward in _rewards) {
      output.add(RewardCard(reward));
    }
    return output;
  }

  @override
  Widget build(BuildContext context) {
    if (_rewards == null) {
      return const LinearProgressIndicator();
    }

    return Column(
      children: _rewardsCards(),
    );
  }
}
