import 'package:flutter/material.dart';

import 'package:habitflow/blocs/points_bloc.dart';
import 'package:habitflow/blocs/rewards_bloc.dart';
import 'package:habitflow/components/reward_points.dart';
import 'package:habitflow/components/rewards_list.dart';
import 'package:habitflow/helpers/intro.dart';
import 'package:habitflow/resources/behaviour.dart';
import 'package:habitflow/resources/icons.dart';
import 'package:habitflow/resources/routes.dart';
import 'package:habitflow/resources/widgets.dart';
import 'package:provider/provider.dart';

/// A screen to show all rewards and allow user to delete and take reward.
class Rewards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PointsBloc pointsBloc = Provider.of<PointsBloc>(context);
    final RewardsBloc rewardsBloc = Provider.of<RewardsBloc>(context);

    if (rewardsBloc.rewards == null || pointsBloc.points == null) {
      return circularIndicator;
    }

    return Scaffold(
      appBar: AppBar(
        title: RewardPoints(
          isTitle: true,
          points: pointsBloc.points,
          style: Theme.of(context).textTheme.headline5,
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        physics: scrollPhysics,
        child: RewardsList(rewardsBloc.rewards),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: createRewardRoute,
        onPressed: () => Navigator.of(context).pushNamed(createRewardRoute),
        child: const Icon(addIcon),
      ),
    );
  }
}
