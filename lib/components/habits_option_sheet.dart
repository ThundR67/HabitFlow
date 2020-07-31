import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import 'package:habitflow/blocs/current_cycle_bloc.dart';
import 'package:habitflow/blocs/habits_bloc.dart';
import 'package:habitflow/blocs/points_bloc.dart';
import 'package:habitflow/models/habit.dart';
import 'package:habitflow/models/status.dart';
import 'package:habitflow/models/success_rate.dart';

class _Button {
  _Button(this.text, this.status, this.color, this.onPressed);
  final String text;
  final Status status;
  final Color color;
  final Function onPressed;
}

/// Allows user to review the failure.
class FailureReviewSheet extends StatelessWidget {
  /// Constructs.
  FailureReviewSheet(this._habit, this._bloc);

  final CurrentCycleBloc _bloc;
  final Habit _habit;
  final TextEditingController _controller = TextEditingController();

  /// Marks [_habit] as failure.
  void _done(BuildContext context) {
    _bloc.fail(_habit.id, _controller.text);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      color: Colors.black,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: <Widget>[
          TextField(
            controller: _controller,
            decoration: const InputDecoration(labelText: 'Failure Reason'),
          ),
          RaisedButton(
            child: const Text('Done'),
            color: Colors.blue,
            onPressed: () => _done(context),
          ),
        ],
      ),
    );
  }
}

/// A bottom sheet which allows user to mark habits.
class HabitsOptionSheet extends StatefulWidget {
  /// Constructs.
  const HabitsOptionSheet(
    this._habit,
    this._status, {
    Key key,
  }) : super(key: key);

  final Habit _habit;
  final Status _status;

  @override
  _HabitsOptionSheetState createState() => _HabitsOptionSheetState();
}

class _HabitsOptionSheetState extends State<HabitsOptionSheet> {
  List<Widget> _childrens(BuildContext context) {
    final CurrentCycleBloc cycleBloc = Provider.of<CurrentCycleBloc>(context);
    final PointsBloc pointsBloc = Provider.of<PointsBloc>(context);

    final List<Widget> output = <Widget>[];
    final List<_Button> buttons = <_Button>[
      _Button(
        'DONE',
        Status.done,
        Colors.greenAccent,
        () {
          cycleBloc.done(widget._habit.id);
          pointsBloc.increment(widget._habit.points);
        },
      ),
      _Button(
        'FAIL',
        Status.failed,
        Colors.redAccent,
        () {
          Scaffold.of(context).showBottomSheet<FailureReviewSheet>(
            (BuildContext context) => FailureReviewSheet(
              widget._habit,
              cycleBloc,
            ),
          );
        },
      ),
      _Button(
        'SKIP',
        Status.skipped,
        Colors.blueAccent,
        () => cycleBloc.skip(widget._habit.id),
      ),
      _Button(
        'UNDO',
        Status.unmarked,
        Colors.amber,
        () => cycleBloc.undo(widget._habit.id),
      ),
    ];

    for (final _Button button in buttons) {
      if (widget._status != button.status) {
        output.add(
          RaisedButton(
            onPressed: () {
              button.onPressed();
              if (button.status != Status.failed) {
                Navigator.of(context).pop();
              }
            },
            color: button.color,
            child: Text(button.text),
          ),
        );
      }
    }
    return output;
  }

  @override
  Widget build(BuildContext context) {
    final CurrentCycleBloc currentBloc = Provider.of<CurrentCycleBloc>(context);
    final HabitsBloc habitsBloc = Provider.of<HabitsBloc>(context);

    final double successRate = calculateHabitSuccessRate(
      widget._habit.id,
      currentBloc.current.days,
    );
    return Container(
      height: 250,
      color: Colors.black,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _childrens(context),
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                children: <Widget>[
                  const Text(
                    'Completion Rate',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  CircularPercentIndicator(
                    radius: 64.0,
                    lineWidth: 4.0,
                    progressColor: Colors.greenAccent[400],
                    percent: successRate,
                    backgroundColor: Colors.transparent,
                    center: Text(
                      (successRate * 100).toStringAsFixed(1) + '%',
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  const Text(
                    'Times Completed',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    calculateTimesCompleted(
                      widget._habit.id,
                      currentBloc.current.days,
                    ).toString(),
                    style: const TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          RaisedButton(
            color: Colors.grey,
            child: Text(tr('delete')),
            onPressed: () {
              habitsBloc.delete(widget._habit);
              currentBloc.delete(widget._habit.id);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
