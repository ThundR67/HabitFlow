import 'package:flutter/material.dart';

import 'package:habitflow/components/neu_card.dart';

/// A widget to show current reward points held by user.
class RewardPoints extends StatelessWidget {
  /// Constructs
  const RewardPoints(this._points, {Key key}) : super(key: key);

  final int _points;

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: NeuCard(
        radius: 10,
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('hello'),
          ),
        ),
      ),
    );
  }
}
