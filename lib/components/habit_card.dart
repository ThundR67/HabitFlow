import 'package:flutter/material.dart';

import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import 'package:habitflow/blocs/current_bloc.dart';
import 'package:habitflow/blocs/intro_bloc.dart';
import 'package:habitflow/blocs/points_bloc.dart';
import 'package:habitflow/components/action_buttons.dart';
import 'package:habitflow/components/main_card.dart';
import 'package:habitflow/components/redirect.dart';
import 'package:habitflow/components/reward_points.dart';
import 'package:habitflow/components/status_view.dart';
import 'package:habitflow/helpers/colors.dart';
import 'package:habitflow/models/habit.dart';
import 'package:habitflow/models/status.dart';
import 'package:habitflow/resources/routes.dart';
import 'package:habitflow/resources/strings.dart';
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
    return MainCard(
      intro: habitIntro,
      actions: _actions(context),
      secondaryActions: _secondaryActions(context),
      onTap: () => redirect(context, habitInfoRoute, HabitInfo(habit)),
      description: habitSwipeDescription,
      controller: controller,
      child: Row(
        children: <Widget>[
          Icon(
            mapToIconData(habit.iconData),
            color: _isUnmarked ? hexToColor(habit.colorHex) : Colors.grey,
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Opacity(
                  opacity: status == Status.unmarked ? 1 : 0.5,
                  child: Text(
                    habit.name,
                    style: Theme.of(context).textTheme.headline6.copyWith(
                          color: _isUnmarked ? textColor : Colors.grey,
                        ),
                  ),
                ),
                const SizedBox(height: 4),
                if (!_isUnmarked)
                  HabitStatus(status: status)
                else
                  RewardPoints(points: habit.points)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
