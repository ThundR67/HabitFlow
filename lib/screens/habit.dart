import 'package:flutter/material.dart';
import 'package:habitflow/models/habit.dart';

/// A screen to show info about [habit].
class HabitInfo extends StatelessWidget {
  /// Constructs.
  const HabitInfo(this._habit);

  final Habit _habit;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(_habit.id),
    );
  }
}
