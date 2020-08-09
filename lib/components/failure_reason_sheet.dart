import 'package:flutter/material.dart';

import 'package:habitflow/blocs/current_bloc.dart';
import 'package:habitflow/helpers/sounds.dart';
import 'package:habitflow/models/habit.dart';
import 'package:habitflow/models/status.dart';
import 'package:habitflow/resources/strings.dart';
import 'package:provider/provider.dart';

/// Allows user to provide reason for failure and then marks [habit] as failed.
class FailureReasonSheet extends StatelessWidget {
  /// Constructs.
  FailureReasonSheet(this.id);

  /// Habit on which user is failing.
  final String id;
  final TextEditingController _controller = TextEditingController();

  /// Marks [habit] as failure.
  void _done(BuildContext context) {
    final CurrentBloc bloc = Provider.of<CurrentBloc>(
      context,
      listen: false,
    );
    bloc.mark(id, Status.failed, _controller.text);
    play('failure');
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: <Widget>[
          TextField(
            controller: _controller,
            decoration: InputDecoration(labelText: failureReason),
          ),
          RaisedButton(
            color: Theme.of(context).accentColor,
            onPressed: () => _done(context),
            child: Text(done),
          ),
        ],
      ),
    );
  }
}
