import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:habitflow/components/habit_card.dart';
import 'package:habitflow/components/no_possesion.dart';
import 'package:habitflow/models/habit.dart';
import 'package:habitflow/models/status.dart';
import 'package:habitflow/resources/icons.dart';
import 'package:habitflow/resources/strings.dart';

/// A widget to show all habits in list.
class HabitsList extends StatelessWidget {
  /// Constructs
  HabitsList({this.habits, this.statuses});

  /// All the habits.
  final Map<String, Habit> habits;

  /// All the statuses.
  final Map<String, Status> statuses;

  /// Controller for all slidables.
  final SlidableController slidableController = SlidableController();

  /// Returns list of habitcards.
  List<Widget> _habitsCards() {
    final List<Widget> output = <Widget>[];
    for (final Habit habit in habits.values) {
      if (habit.goal.activeDays.contains(DateTime.now().weekday)) {
        output.add(
          HabitCard(
            controller: slidableController,
            habit: habit,
            status: statuses[habit.id] ?? Status.unmarked,
          ),
        );
      }
    }
    return output;
  }

  /// Returns if is there active habits on current day.
  bool _isActiveToday() {
    for (final Habit habit in habits.values) {
      if (habit.goal.activeDays.contains(DateTime.now().weekday)) return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    if (habits.isEmpty) return NoPossesion(text: noHabits);
    if (!_isActiveToday()) {
      return NoPossesion(
        text: noActiveHabits,
        icon: noActiveHabitsIcon,
      );
    }

    if (slidableController.activeState != null) {
      slidableController.activeState.open();
    }

    return Column(
      children: _habitsCards(),
    );
  }
}
