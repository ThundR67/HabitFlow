import 'package:flutter/material.dart';
import 'package:habitflow/blocs/points_bloc.dart';
import 'package:habitflow/models/reward.dart';
import 'package:provider/provider.dart';

import 'package:habitflow/blocs/rewards_bloc.dart';

/// A bottom sheet which allows user to either delete or take a reward.
class RewardOptionsSheet extends StatelessWidget {
  /// Constructs.
  const RewardOptionsSheet(this._reward, {Key key}) : super(key: key);

  final Reward _reward;

  @override
  Widget build(BuildContext context) {
    final RewardsBloc rewardsBloc = Provider.of<RewardsBloc>(context);
    final PointsBloc pointsBloc = Provider.of<PointsBloc>(context);

    return Container(
      height: 160,
      color: Colors.black,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              if (_reward.points > pointsBloc.points) {
                const SnackBar snackBar = SnackBar(
                    content: Text("You don't have enough reward points"));
                Scaffold.of(context).showSnackBar(snackBar);
                Navigator.pop(context);
                return;
              }
              rewardsBloc.take(_reward);
              pointsBloc.decrement(_reward.points);
            },
            child: const Text('Take This Reward'),
          ),
          RaisedButton(
            onPressed: () {
              rewardsBloc.delete(_reward);
              Navigator.pop(context);
            },
            child: const Text('Delete This Reward'),
          ),
        ],
      ),
    );
  }
}
