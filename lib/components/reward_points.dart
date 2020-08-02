import 'package:flutter/material.dart';

import 'package:habitflow/resources/icons.dart';

/// A widget to show reward points with the icon.
class RewardPoints extends StatelessWidget {
  /// Constructs
  const RewardPoints(
    this._points, {
    Key key,
    this.size = 16.0,
    this.color = Colors.yellow,
  }) : super(key: key);

  final int _points;

  /// Size of the widget.
  final double size;

  /// Color of the icon.
  final Color color;

  @override
  Widget build(BuildContext context) {
    if (_points == -1) {
      return const CircularProgressIndicator();
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          _points.toString(),
          style: TextStyle(
            fontSize: size,
          ),
        ),
        const SizedBox(
          width: 2,
        ),
        Icon(
          rewardIcon,
          size: size,
          color: color,
        ),
      ],
    );
  }
}
