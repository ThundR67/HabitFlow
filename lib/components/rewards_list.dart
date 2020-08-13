import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:habitflow/components/no_possesion.dart';
import 'package:habitflow/components/reward_card.dart';
import 'package:habitflow/models/reward.dart';
import 'package:habitflow/resources/strings.dart';

/// A widget to show all rewards in list.
class RewardsList extends StatelessWidget {
  /// Constructs.
  RewardsList(this._rewards);

  /// List of reward to show.
  final List<Reward> _rewards;

  /// Controller for slidables.
  final SlidableController _controller = SlidableController();

  /// Creates list of RewardCard.
  List<Widget> _rewardsCards() {
    final List<Widget> output = <Widget>[];
    for (final Reward reward in _rewards) {
      output.add(
        RewardCard(
          reward: reward,
          controller: _controller,
        ),
      );
    }
    return output;
  }

  @override
  Widget build(BuildContext context) {
    if (_rewards == null) return const LinearProgressIndicator();
    if (_rewards.isEmpty) return NoPossesion(text: noRewards);

    return Column(
      children: _rewardsCards(),
    );
  }
}
