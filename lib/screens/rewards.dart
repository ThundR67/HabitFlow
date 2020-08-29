import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:habitflow/blocs/points_bloc.dart';
import 'package:habitflow/blocs/rewards_bloc.dart';
import 'package:habitflow/components/reward_points.dart';
import 'package:habitflow/components/rewards_list.dart';
import 'package:habitflow/resources/icons.dart';
import 'package:habitflow/resources/routes.dart';

/// A screen to show all rewards and allow user to delete and take reward.
class Rewards extends StatelessWidget {
  /// Rewards.
  const Rewards();

  @override
  Widget build(BuildContext context) {
    final PointsBloc pointsBloc = Provider.of<PointsBloc>(context);
    final RewardsBloc rewardsBloc = Provider.of<RewardsBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            RewardPoints(
              points: pointsBloc.points,
              style: Theme.of(context).textTheme.headline5,
              isCenter: true,
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: RewardsList(rewardsBloc.rewards),
      floatingActionButton: FloatingActionButton(
        heroTag: createRewardRoute,
        onPressed: () => Navigator.of(context).pushNamed(createRewardRoute),
        child: const Icon(addIcon),
      ),
    );
  }
}
