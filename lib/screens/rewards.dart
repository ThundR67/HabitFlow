import 'package:flutter/material.dart';

import 'package:habitflow/blocs/points_bloc.dart';
import 'package:habitflow/blocs/rewards_bloc.dart';
import 'package:habitflow/components/cur_reward_points.dart';
import 'package:habitflow/components/rewards_list.dart';
import 'package:habitflow/resources/behaviour.dart';
import 'package:habitflow/resources/icons.dart';

/// A page to show all rewards and allow user to create and take reward.
class Rewards extends StatelessWidget {
  /// Constructs
  const Rewards(
    this._rewardsBloc,
    this._pointsBloc, {
    Key key,
  }) : super(key: key);

  final PointsBloc _pointsBloc;
  final RewardsBloc _rewardsBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: scrollPhysics,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              CurRewardPoints(_pointsBloc.points),
              RewardsList(_rewardsBloc.rewards),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'create_reward',
        onPressed: () {
          Navigator.of(context).pushNamed('/create_reward');
        },
        child: const Icon(addIcon),
      ),
    );
  }
}
