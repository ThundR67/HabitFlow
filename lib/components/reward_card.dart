import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:habitflow/blocs/points_bloc.dart';
import 'package:habitflow/blocs/rewards_bloc.dart';
import 'package:habitflow/components/action_buttons.dart';
import 'package:habitflow/components/main_card.dart';
import 'package:habitflow/components/reward_points.dart';

import 'package:habitflow/helpers/colors.dart';
import 'package:habitflow/models/reward.dart';
import 'package:habitflow/resources/strings.dart';
import 'package:provider/provider.dart';

/// A widget to show a reward in a card.
class RewardCard extends StatelessWidget {
  /// Constructs.
  const RewardCard({this.reward, this.controller});

  /// Reward to show.
  final Reward reward;

  /// Slidable Controller.
  final SlidableController controller;

  @override
  Widget build(BuildContext context) {
    final RewardsBloc rewardsBloc = Provider.of<RewardsBloc>(context);
    final PointsBloc pointsBloc = Provider.of<PointsBloc>(context);
    return MainCard(
      actions: [takeAction(context, reward, rewardsBloc, pointsBloc)],
      secondaryActions: [deleteAction(reward, rewardsBloc)],
      description: rewardSwipeDescription,
      controller: controller,
      onTap: () {},
      child: Row(
        children: <Widget>[
          Icon(
            mapToIconData(reward.iconData),
            color: hexToColor(reward.colorHex),
          ),
          const SizedBox(width: 16.0),
          _RewardName(reward),
          RewardPoints(
            points: reward.points,
            color: hexToColor(reward.colorHex),
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      ),
    );
  }
}

/// Displays reward's name and amount taken.
class _RewardName extends StatelessWidget {
  const _RewardName(this._reward);

  final Reward _reward;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            _reward.name,
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(width: 8.0),
          Text(
            'X ${_reward.amountTaken}',
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ],
      ),
    );
  }
}
