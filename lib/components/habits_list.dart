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

  /// Returns list of habitcards.
  List<Widget> _habitsCards() {
    final List<Widget> output = <Widget>[];
    for (final Habit habit in habits.values) {
      if (habit.activeDays.contains(DateTime.now().weekday)) {
        output.add(
          HabitCard(
            habit: habit,
            status: statuses[habit.id] ?? Status.unmarked,
          ),
        );
      }
    }
    return output;
  }

  @override
  Widget build(BuildContext context) {
    if (habits == null || statuses == null) {
      return const LinearProgressIndicator();
    }
    return Column(
      children: _habitsCards(),
    );
  }
}
