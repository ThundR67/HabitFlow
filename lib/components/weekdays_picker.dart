import 'package:flutter/material.dart';

import 'package:weekday_selector/weekday_selector.dart';

/// A widget to allow user to pick weekdays.
class WeekdaysPicker extends StatefulWidget {
  /// Constructs.
  const WeekdaysPicker({@required this.onChange, @required this.color});

  /// Function to run when weekdays change.
  final Function onChange;

  /// Color of the widget.
  final Color color;

  @override
  _WeekdaysPickerState createState() => _WeekdaysPickerState();
}

class _WeekdaysPickerState extends State<WeekdaysPicker> {
  final List<bool> values = List<bool>.filled(7, false);

  /// Updates [_values].
  void _updateValues(int day) {
    setState(() {
      final int index = day % 7;
      values[index] = !values[index];
    });
  }

  /// Creates list of active days and calls [widget.onChange].
  void _onChange() {
    final List<int> activeDays = <int>[];
    for (int i = 0; i < values.length; i++) {
      if (values[i] && i == 0) {
        activeDays.add(7);
      } else if (values[i]) {
        activeDays.add(i);
      }
    }
    widget.onChange(activeDays);
  }

  @override
  Widget build(BuildContext context) {
    return WeekdaySelector(
      selectedFillColor: widget.color,
      onChanged: (int day) {
        _updateValues(day);
        _onChange();
      },
      values: values,
    );
  }
}
