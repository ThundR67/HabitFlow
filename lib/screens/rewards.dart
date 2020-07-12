import 'package:flutter/material.dart';

import 'package:habitflow/blocs/points_bloc.dart';
import 'package:habitflow/blocs/rewards_bloc.dart';
import 'package:habitflow/components/reward_points.dart';

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
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          RewardPoints(_pointsBloc.points),
        ],
      ),
    );
  }
}
