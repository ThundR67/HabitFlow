import 'package:flutter/material.dart';

import 'package:habitflow/resources/strings.dart';

/// A notification time selector button.
///
/// Allows user to select a time.
/// Displays current selected time.
/// If no time selected, displays a prompt.
class NotificationTimeSelector extends StatefulWidget {
  /// Constructs.
  const NotificationTimeSelector({
    @required this.color,
    @required this.onChange,
  });

  /// Color of button.
  final Color color;

  /// Function to run when time is selected.
  final Function(TimeOfDay) onChange;

  @override
  _NotificationTimeSelectorState createState() =>
      _NotificationTimeSelectorState();
}

class _NotificationTimeSelectorState extends State<NotificationTimeSelector> {
  TimeOfDay _time;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        onPressed: () async {
          _time = await showTimePicker(
            context: context,
            initialTime: _time ?? TimeOfDay.now(),
          );
          setState(() => widget.onChange(_time));
        },
        color: widget.color,
        child: _time == null
            ? Text(
                selectTime,
                style: Theme.of(context)
                    .textTheme
                    .button
                    .copyWith(color: Colors.white),
              )
            : Text(
                _time.format(context),
                style: Theme.of(context).textTheme.headline6.copyWith(
                      color: Colors.white,
                    ),
              ),
      ),
    );
  }
}
