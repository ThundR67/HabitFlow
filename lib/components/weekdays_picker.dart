import 'package:flutter/material.dart';

import 'package:weekday_selector/weekday_selector.dart';

/// A widget to allow user to pick weekdays.
class WeekdaysPicker extends StatefulWidget {
  /// Constructs.
  const WeekdaysPicker(
    this._onChange,
    this._color, {
    Key key,
  }) : super(key: key);

  final Function _onChange;
  final Color _color;

  @override
  _WeekdaysPickerState createState() => _WeekdaysPickerState();
}

class _WeekdaysPickerState extends State<WeekdaysPicker> {
  _WeekdaysPickerState();

  final List<bool> values = List<bool>.filled(7, false);

  @override
  Widget build(BuildContext context) {
    return WeekdaySelector(
      selectedFillColor: widget._color,
      onChanged: (int day) {
        final List<int> activeDays = <int>[];
        setState(() {
          final int index = day % 7;
          values[index] = !values[index];
        });
        for (int i = 0; i < values.length; i++) {
          if (values[i] && i == 0) {
            activeDays.add(7);
          } else if (values[i]) {
            activeDays.add(i);
          }
        }
        widget._onChange(activeDays);
      },
      values: values,
    );
  }
}
