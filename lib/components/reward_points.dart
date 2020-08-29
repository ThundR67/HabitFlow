import 'package:flutter/material.dart';

import 'package:habitflow/resources/icons.dart';

/// A row widget to show [points] with the icon of [color].
class RewardPoints extends StatelessWidget {
  /// Constructs
  const RewardPoints({
    @required this.points,
    this.style,
    this.color = Colors.orange,
    this.isCenter = false,
  });

  /// Amount of points.
  final int points;

  /// Style of text.
  final TextStyle style;

  /// Color of the icon.
  final Color color;

  /// Should text be centered with icon on right.
  final bool isCenter;

  @override
  Widget build(BuildContext context) {
    final TextStyle newStyle = style ?? Theme.of(context).textTheme.subtitle1;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (isCenter) SizedBox(width: newStyle.fontSize),
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
