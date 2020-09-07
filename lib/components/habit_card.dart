import 'package:flutter/material.dart';

import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:habitflow/components/action_buttons.dart';
import 'package:habitflow/components/slidable_card.dart';
import 'package:habitflow/components/redirect.dart';
import 'package:habitflow/components/reward_points.dart';
import 'package:habitflow/components/status_view.dart';
import 'package:habitflow/helpers/colors.dart';
import 'package:habitflow/models/habit.dart';
import 'package:habitflow/models/status.dart';
import 'package:habitflow/resources/routes.dart';
import 'package:habitflow/screens/habit.dart';

// TODO clean after proxy

/// A widget to show a card of [habit].
class HabitCard extends StatelessWidget {
  /// Constructs
  const HabitCard({
    @required this.habit,
    @required this.status,
    @required this.controller,
  }) : _isUnmarked = Status.unmarked == status;

  /// Habit to show.
  final Habit habit;

  /// Status of [habit].
  final Status status;

  /// Controller for slidable.
  final SlidableController controller;

  // If status is unmarked.
  final bool _isUnmarked;

  /// Returns all primary actions on habit.
  List<Widget> _actions(BuildContext context) {
    final List<Widget> actions = [doneAction(context, habit)];
    return _isUnmarked ? actions : [undoAction(context, habit)];
  }

  /// Returns all secondary actions on habit.
  List<Widget> _secondaryActions(BuildContext context) {
    final List<Widget> actions = <Widget>[
      skipAction(context, habit),
      failAction(context, habit),
    ];
    return _isUnmarked ? actions : [undoAction(context, habit)];
  }

  @override
  Widget build(BuildContext context) {
    final Color textColor = Theme.of(context).textTheme.headline6.color;

    return SlidableCard(
      controller: controller,
      actions: _actions(context),
      secondaryActions: _secondaryActions(context),
      child: ListTile(
        onTap: () => redirect(context, habitInfoRoute, HabitInfo(habit)),
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Icon(
            mapToIconData(habit.iconData),
            color: _isUnmarked ? hexToColor(habit.colorHex) : Colors.grey,
            size: 24,
          ),
        ),
        title: Text(
          habit.name,
          style: Theme.of(context).textTheme.headline6.copyWith(
                color: _isUnmarked ? textColor : Colors.grey,
              ),
        ),
        subtitle: !_isUnmarked
            ? HabitStatus(status: status)
            : RewardPoints(points: habit.points),
      ),
    );
  }
}
