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

  /// Returns color based on [status].
  Color _color() {
    switch (status) {
      case Status.done:
        return Colors.greenAccent;
      case Status.skipped:
        return Colors.blueAccent;
      case Status.failed:
        return Colors.redAccent;
      default:
        return Colors.black;
    }
  }

  /// Returns icon based on [status].
  IconData _icon() {
    switch (status) {
      case Status.done:
        return doneIcon;
      case Status.skipped:
        return skippedIcon;
      case Status.failed:
        return failedIcon;
      default:
        return emptyIcon;
    }
  }

  /// Returns text based on [status].
  String _text() {
    switch (status) {
      case Status.done:
        return done;
      case Status.skipped:
        return skipped;
      case Status.failed:
        return failed;
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final double fontSize = Theme.of(context).textTheme.subtitle1.fontSize;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          _icon(),
          color: _color(),
          size: fontSize,
        ),
        const SizedBox(width: 4.0),
        Text(
          _text().toLowerCase(),
          style: TextStyle(
            color: _color(),
            fontSize: fontSize,
          ),
        ),
      ],
    );
  }
}
