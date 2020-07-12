import 'package:flutter/material.dart';

/// A widget to show current reward points held by user.
class RewardPoints extends StatelessWidget {
  /// Constructs
  const RewardPoints(this._points, {Key key}) : super(key: key);

  final int _points;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(_points.toString()),
    );
  }
}
