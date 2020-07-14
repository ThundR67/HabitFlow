import 'package:flutter/material.dart';
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
    RewardsBloc rewardsBloc = Provider.of<RewardsBloc>(context);
    return Container(
      height: 160,
      color: Colors.black,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              rewardsBloc.take(_reward);
              Navigator.pop(context);
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
