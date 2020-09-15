import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:habitflow/components/habit_card.dart';
import 'package:habitflow/components/quick_sup.dart';
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

  /// Returns if is there active habits on current day.
  bool _isActiveToday() {
    for (final Habit habit in habits.values) {
      if (habit.goal.activeDays.contains(DateTime.now().weekday)) return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    if (habits.isEmpty) {
      return QuickSup(
        title: noRewardsTitle,
        subtitle: noRewardsSubtitle,
      );
    }

    if (!_isActiveToday()) {
      return QuickSup(
        title: noActiveHabitsTitle,
        subtitle: noActiveHabitsSubtitle,
        icon: noActiveHabitsIcon,
      );
    }

    final int currentWeekday = DateTime.now().weekday;

    return ListView.builder(
      itemCount: habits.values.length,
      itemBuilder: (context, index) {
        final Habit habit = habits.values.toList()[index];
        if (habit.goal.activeDays.contains(currentWeekday)) {
          return HabitCard(
            controller: slidableController,
            habit: habit,
            status: statuses[habit.id] ?? Status.unmarked,
          );
        }
        return Container();
      },
    );
  }
}
