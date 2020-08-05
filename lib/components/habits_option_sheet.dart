import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import 'package:habitflow/blocs/current_cycle_bloc.dart';
import 'package:habitflow/blocs/habits_bloc.dart';
import 'package:habitflow/blocs/points_bloc.dart';
import 'package:habitflow/models/habit.dart';
import 'package:habitflow/models/status.dart';
import 'package:habitflow/helpers/success_rate.dart';

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
    _bloc.mark(_habit.id, Status.failed, _controller.text);
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
