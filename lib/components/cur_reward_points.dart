import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:habitflow/components/neu_card.dart';
import 'package:habitflow/components/reward_points.dart';

/// A widget to show current reward points held by user.
class CurRewardPoints extends StatelessWidget {
  /// Constructs
  const CurRewardPoints(this._points, {Key key}) : super(key: key);

  final int _points;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: NeuCard(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(tr('currentPoints')),
                RewardPoints(
                  _points,
                  size: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
