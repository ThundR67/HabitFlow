import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:habitflow/resources/strings.dart';
import 'package:tinycolor/tinycolor.dart';

/// Button to allow user to select notification time.
class NotificationTimeSelector extends StatefulWidget {
  /// Constructs.
  const NotificationTimeSelector({
    @required this.color,
    @required this.onChange,
  });

  /// Color of button.
  final Color color;

  /// Function to run onChange.
  final Function(TimeOfDay) onChange;

  @override
  _NotificationTimeSelectorState createState() =>
      _NotificationTimeSelectorState();
}

class _NotificationTimeSelectorState extends State<NotificationTimeSelector> {
  TimeOfDay _time;

  void _onChange(TimeOfDay time) {
    setState(() {
      _time = time;
      widget.onChange(time);
    });
  }

  Color _textColor() {
    return TinyColor(widget.color).isLight() ? Colors.black : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        onPressed: () {
          Navigator.of(context).push(
            showPicker(
              context: context,
              value: _time ??
                  const TimeOfDay(
                    hour: 12,
                    minute: 0,
                  ),
              onChange: _onChange,
            ),
          );
        },
        color: widget.color,
        child: _time == null
            ? Text(
                selectTime,
                style: Theme.of(context).textTheme.button.copyWith(
                      color: _textColor(),
                    ),
              )
            : Text(
                _time.format(context),
                style: Theme.of(context).textTheme.headline6.copyWith(
                      color: _textColor(),
                    ),
              ),
      ),
    );
  }
}
