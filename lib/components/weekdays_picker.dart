import 'package:flutter/material.dart';
import 'package:weekday_selector/weekday_selector.dart';

/// A widget to allow user to pick weekdays.
class WeekdaysPicker extends StatefulWidget {
  /// Constructs.
  const WeekdaysPicker(this._onChange, {Key key}) : super(key: key);

  final Function _onChange;

  @override
  _WeekdaysPickerState createState() => _WeekdaysPickerState(_onChange);
}

class _WeekdaysPickerState extends State<WeekdaysPicker> {
  _WeekdaysPickerState(this._onChange);

  final List<bool> values = List<bool>.filled(7, true);
  final Function _onChange;

  @override
  Widget build(BuildContext context) {
    return WeekdaySelector(
      onChanged: (int day) {
        final List<int> activeDays = <int>[];
        setState(() {
          final int index = day % 7;
          values[index] = !values[index];
        });
        for (int i = 0; i < values.length; i++) {
          if (values[i]) {
            activeDays.add(i + 1); // As DateTime starts with 1 for monday.
          }
        }
        _onChange(activeDays);
      },
      values: values,
    );
  }
}
