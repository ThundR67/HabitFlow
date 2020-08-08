import 'package:flutter/material.dart';

import 'package:habitflow/resources/icons.dart';

/// A widget to show reward points with the icon.
class RewardPoints extends StatelessWidget {
  /// Constructs
  const RewardPoints({
    @required this.points,
    this.style,
    this.color = Colors.orange,
  });

  /// Amount of points.
  final int points;

  /// Style of text.
  final TextStyle style;

  /// Color of the icon.
  final Color color;

  @override
  Widget build(BuildContext context) {
    final TextStyle newStyle = style ?? Theme.of(context).textTheme.subtitle1;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          points.toString(),
          style: newStyle,
        ),
        const SizedBox(width: 2),
        Icon(
          rewardIcon,
          size: newStyle.fontSize,
          color: color,
        ),
      ],
    );
  }
}
