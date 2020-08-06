import 'package:flutter/material.dart';

import 'package:habitflow/components/habit_card.dart';
import 'package:habitflow/resources/behaviour.dart';

import 'package:habitflow/models/habit.dart';
import 'package:habitflow/models/status.dart';

/// A widget to show all habits in list.
class HabitsList extends StatelessWidget {
  /// Constructs
  const HabitsList({this.habits, this.statuses});

  /// All the habits.
  final Map<String, Habit> habits;

  /// All the statuses.
  final Map<String, Status> statuses;

  @override
  Widget build(BuildContext context) {
    if (habits == null || statuses == null) {
      return const LinearProgressIndicator();
    }
    return ListView.builder(
      physics: scrollPhysics,
      shrinkWrap: true,
      padding: const EdgeInsets.all(8.0),
      itemCount: habits.values.length,
      itemBuilder: (_, int index) {
        final Habit habit = habits.values.toList()[index];
        if (habit.activeDays.contains(DateTime.now().weekday)) {
          return HabitCard(
            habit: habit,
            status: statuses[habit.id],
          );
        }
        return null;
      },
    );
  }
}
