import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:habitflow/blocs/current_bloc.dart';
import 'package:habitflow/blocs/points_bloc.dart';
import 'package:habitflow/components/action_buttons.dart';
import 'package:habitflow/components/reward_points.dart';
import 'package:habitflow/components/status_view.dart';
import 'package:habitflow/components/tappable_neu_card.dart';
import 'package:habitflow/helpers/colors.dart';
import 'package:habitflow/models/habit.dart';
import 'package:habitflow/models/status.dart';
import 'package:provider/provider.dart';

/// A widget to show a card of [habit].
class HabitCard extends StatelessWidget {
  /// Constructs
  const HabitCard({
    @required this.habit,
    @required this.status,
  });

  /// Habit to show.
  final Habit habit;

  /// Status of [habit].
  final Status status;

  /// Returns all primary actions on habit.
  List<Widget> _actions(CurrentBloc bloc, PointsBloc pointsBloc) {
    return <Widget>[doneAction(habit, pointsBloc, bloc)];
  }

  /// Returns all secondary actions on habit.
  List<Widget> _secondaryActions(BuildContext context, CurrentBloc bloc) {
    return <Widget>[
      skipAction(habit, bloc),
      failAction(context, habit),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final CurrentBloc currentBloc = Provider.of<CurrentBloc>(context);
    final PointsBloc pointsBloc = Provider.of<PointsBloc>(context);
    final bool isUnmarked = status == Status.unmarked;

    return Slidable(
      actions: isUnmarked
          ? _actions(currentBloc, pointsBloc)
          : <Widget>[undoAction(habit, currentBloc)],
      secondaryActions: isUnmarked
          ? _secondaryActions(context, currentBloc)
          : <Widget>[undoAction(habit, currentBloc)],
      actionPane: const SlidableDrawerActionPane(),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 16.0,
        ),
        child: TappableCard(
          onTap: () {},
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    mapToIconData(habit.iconData),
                    color:
                        isUnmarked ? hexToColor(habit.colorHex) : Colors.grey,
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
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        const SizedBox(height: 4),
                        if (!isUnmarked)
                          StatusView(status: status)
                        else
                          RewardPoints(points: habit.points)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
