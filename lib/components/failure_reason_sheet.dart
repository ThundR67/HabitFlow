import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:habitflow/blocs/current_bloc.dart';
import 'package:habitflow/helpers/sounds.dart';
import 'package:habitflow/models/status.dart';
import 'package:habitflow/resources/strings.dart';

/// Allows user to provide reason for failure and then marks [habit] on [date] as failed.
class FailureReasonSheet extends StatelessWidget {
  /// Constructs.
  FailureReasonSheet({
    @required this.id,
    this.date,
  });

  /// Id of habit which user is failing.
  final String id;

  /// Date when habit needs to be marked as failed. Defaults current day.
  final DateTime date;

  final TextEditingController _controller = TextEditingController();

  /// Marks [habit] as failure.
  void _done(BuildContext context) {
    Provider.of<CurrentBloc>(context, listen: false).mark(
      id,
      Status.failed,
      date: date ?? DateTime.now(),
      reason: _controller.text,
    );
    play('failure');
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets,
      duration: const Duration(milliseconds: 100),
      child: Container(
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
      ),
    );
  }
}
