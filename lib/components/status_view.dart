import 'package:flutter/material.dart';

import 'package:habitflow/models/status.dart';
import 'package:habitflow/resources/icons.dart';
import 'package:habitflow/resources/strings.dart';

/// A widget to show [status] of a habit such as done or skipped.
class HabitStatus extends StatelessWidget {
  //// Constructs.
  const HabitStatus({@required this.status});

  /// Status of habit.
  final Status status;

  @override
  Widget build(BuildContext context) {
    final double fontSize = Theme.of(context).textTheme.subtitle1.fontSize;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          status.icon,
          color: status.color,
          size: fontSize,
        ),
        const SizedBox(width: 4.0),
        Text(
          status.text.toLowerCase(),
          style: TextStyle(
            color: status.color,
            fontSize: fontSize,
          ),
        ),
      ],
    );
  }
}
