import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:habitflow/components/quick_sup.dart';
import 'package:habitflow/components/reward_card.dart';
import 'package:habitflow/models/reward.dart';
import 'package:habitflow/resources/strings.dart';
import 'package:habitflow/resources/widgets.dart';

/// A widget to show all rewards in list.
class RewardsList extends StatelessWidget {
  /// Constructs.
  RewardsList(this._rewards);

  /// List of reward to show.
  final List<Reward> _rewards;

  /// Controller for slidables.
  final SlidableController _controller = SlidableController();

  @override
  Widget build(BuildContext context) {
    if (_rewards == null) return circularIndicator;
    if (_rewards.isEmpty) {
      return QuickSup(
        title: noRewardsTitle,
        subtitle: noRewardsSubtitle,
      );
    }

    return ListView.builder(
      itemCount: _rewards.length,
      itemBuilder: (context, index) => RewardCard(
        reward: _rewards[index],
        controller: _controller,
      ),
    );
  }
}
