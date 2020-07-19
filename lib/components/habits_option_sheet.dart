import 'package:flutter/material.dart';
import 'package:habitflow/blocs/habits_bloc.dart';
import 'package:habitflow/blocs/points_bloc.dart';
import 'package:habitflow/models/habit.dart';
import 'package:habitflow/models/status.dart';
import 'package:provider/provider.dart';

class _Button {
  _Button(this.text, this.status, this.color, this.onPressed);
  final String text;
  final Status status;
  final Color color;
  final Function onPressed;
}

/// A bottom sheet which allows user to either delete or take a reward.
class HabitsOptionSheet extends StatelessWidget {
  /// Constructs.
  const HabitsOptionSheet(
    this._habit,
    this._status, {
    Key key,
  }) : super(key: key);

  final Habit _habit;
  final Status _status;

  List<Widget> _childrens(BuildContext context) {
    final HabitsBloc habitsBloc = Provider.of<HabitsBloc>(context);
    final PointsBloc pointsBloc = Provider.of<PointsBloc>(context);

    final List<Widget> output = <Widget>[];
    final List<_Button> buttons = <_Button>[
      _Button(
        'DONE',
        Status.done,
        Colors.greenAccent,
        () => habitsBloc.done(_habit.id),
      ),
      _Button(
        'FAIL',
        Status.failed,
        Colors.redAccent,
        () => habitsBloc.fail(_habit.id, ''),
      ),
      _Button(
        'SKIP',
        Status.skipped,
        Colors.blueAccent,
        () => habitsBloc.skip(_habit.id),
      ),
      _Button(
        'UNDO',
        Status.unmarked,
        Colors.white,
        () => habitsBloc.undo(_habit.id),
      ),
    ];

    for (final _Button button in buttons) {
      if (_status != button.status) {
        output.add(
          RaisedButton(
            onPressed: () {
              button.onPressed();
              Navigator.of(context).pop();
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
    return Container(
      height: 160,
      color: Colors.black,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _childrens(context),
          ),
        ],
      ),
    );
  }
}
