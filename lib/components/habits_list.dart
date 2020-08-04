import 'package:flutter/material.dart';

import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import 'package:habitflow/blocs/current_cycle_bloc.dart';
import 'package:habitflow/blocs/points_bloc.dart';
import 'package:habitflow/components/action_button.dart';
import 'package:habitflow/components/habits_option_sheet.dart';
import 'package:habitflow/components/neu_card.dart';
import 'package:habitflow/components/reward_points.dart';
import 'package:habitflow/components/status_view.dart';
import 'package:habitflow/models/habit.dart';
import 'package:habitflow/models/status.dart';
import 'package:habitflow/resources/icons.dart';
import 'package:habitflow/resources/strings.dart';

Color _colorFromHex(String hexColor) {
  final String hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));
}

/// A widget to show a single habit.
class _Habit extends StatelessWidget {
  /// Constructs
  const _Habit(this._habit, this._status, {Key key}) : super(key: key);

  final Habit _habit;
  final Status _status;

  // Shows reward options sheet.
  void _showSheet(BuildContext context) {
    Scaffold.of(context).showBottomSheet<HabitsOptionSheet>(
      (BuildContext context) => HabitsOptionSheet(
        _habit,
        _status,
      ),
    );
  }

  /// Shows failure reason prompt.
  void _showFailureReasonSheet(BuildContext context, CurrentCycleBloc bloc) {
    Scaffold.of(context).showBottomSheet<FailureReviewSheet>(
      (BuildContext context) => FailureReviewSheet(
        _habit,
        bloc,
      ),
    );
  }

  /// Returns undo action only.
  List<Widget> _undoAction(CurrentCycleBloc bloc) {
    return <Widget>[
      ActionButton(
        color: Colors.orangeAccent[700],
        text: undo,
        onPressed: () => bloc.undo(_habit.id),
        icon: undoIcon,
      )
    ];
  }

  /// Returns all primary actions on habit.
  List<Widget> _actions(CurrentCycleBloc bloc, PointsBloc pointsBloc) {
    return <Widget>[
      ActionButton(
        color: Colors.green,
        text: done,
        onPressed: () {
          bloc.done(_habit.id);
          pointsBloc.increment(_habit.points);
        },
        icon: doneIcon,
      )
    ];
  }

  /// Returns all secondary actions on habit.
  List<Widget> _secondaryActions(BuildContext context, CurrentCycleBloc bloc) {
    return <Widget>[
      ActionButton(
        color: Colors.blue,
        text: skip,
        onPressed: () => bloc.skip(_habit.id),
        icon: skippedIcon,
      ),
      ActionButton(
        color: Colors.red,
        text: fail,
        onPressed: () => _showFailureReasonSheet(context, bloc),
        icon: failedIcon,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    final CurrentCycleBloc currentBloc = Provider.of<CurrentCycleBloc>(context);
    final PointsBloc pointsBloc = Provider.of<PointsBloc>(context);
    final bool isUnmarked = _status == Status.unmarked;

    return Slidable(
      actions: isUnmarked
          ? _actions(currentBloc, pointsBloc)
          : _undoAction(currentBloc),
      secondaryActions: isUnmarked
          ? _secondaryActions(context, currentBloc)
          : _undoAction(currentBloc),
      actionPane: const SlidableScrollActionPane(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: NeuCard(
          context: context,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _showSheet(context),
              child: Ink(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          mapToIconData(_habit.iconData),
                          color: isUnmarked
                              ? _colorFromHex(_habit.colorHex)
                              : Colors.grey,
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Opacity(
                                opacity: _status == Status.unmarked ? 1 : 0.5,
                                child: Text(
                                  _habit.name,
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ),
                              const SizedBox(height: 4),
                              if (!isUnmarked)
                                StatusView(_status)
                              else
                                RewardPoints(_habit.points)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// A widget to show all habits in list.
class HabitsList extends StatelessWidget {
  /// Constructs
  const HabitsList(this._habits, this._statuses, {Key key}) : super(key: key);

  final List<Habit> _habits;
  final List<Status> _statuses;

  /// Returns all habits.
  List<Widget> _habitsCards() {
    final List<Widget> output = <Widget>[];
    for (int i = 0; i < _habits.length; i++) {
      if (_habits[i].activeDays.contains(DateTime.now().weekday)) {
        Status status = Status.unmarked;
        if (_statuses.length > i) {
          status = _statuses[i];
        }
        output.add(const SizedBox(height: 8.0));
        output.add(
          _Habit(_habits[i], status),
        );
      }
    }
    return output;
  }

  @override
  Widget build(BuildContext context) {
    if (_habits == null || _statuses == null) {
      return const LinearProgressIndicator();
    }
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Column(
        children: _habitsCards(),
      ),
    );
  }
}
