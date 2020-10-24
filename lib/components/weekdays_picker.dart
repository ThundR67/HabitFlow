import 'package:flutter/material.dart';
import 'package:habitflow/resources/strings.dart';
import 'package:tinycolor/tinycolor.dart';

/// A picker to allow user to pick weekdays.
///
/// [onChange] will run when user does certain selection.
/// [onChange] will be provided with list of days index selected by user.
/// Index of monday starts with 1 (Same as of [DateTime]).
class WeekdaysPicker extends StatefulWidget {
  /// Constructs.
  const WeekdaysPicker({
    @required this.onChange,
    @required this.color,
    this.initial,
  });

  /// Function to run when weekdays change.
  final Function(List<int>) onChange;

  /// Color of the widget.
  final Color color;

  /// Initial value.
  final List<int> initial;

  @override
  _WeekdaysPickerState createState() => _WeekdaysPickerState();
}

class _WeekdaysPickerState extends State<WeekdaysPicker> {
  List<int> _daysSelected;

  /// Adds [day] to [_daysSelected] if not exists, else removes it.
  void _onSelect(int day) {
    if (_daysSelected.contains(day)) {
      _daysSelected.remove(day);
    } else {
      _daysSelected.add(day);
    }
    widget.onChange(_daysSelected);
    setState(() {});
  }

  @override
  void initState() {
    _daysSelected = widget.initial ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 48,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: DateTime.daysPerWeek,
        itemBuilder: (context, index) => _Day(
          index: index + 1,
          isSelected: _daysSelected.contains(index + 1),
          onSelect: _onSelect,
          activeColor: widget.color,
        ),
      ),
    );
  }
}

/// A circular card.
class _Day extends StatelessWidget {
  const _Day({
    @required this.index,
    @required this.isSelected,
    @required this.onSelect,
    @required this.activeColor,
  });

  /// Index of the day. (Starts from 1, which is of monday).
  final int index;

  /// If the day selected.
  final bool isSelected;

  /// On card is selected.
  final Function(int) onSelect;

  /// Color when card is selected.
  final Color activeColor;

  @override
  Widget build(BuildContext context) {
    final Color color = isSelected ? activeColor : Theme.of(context).cardColor;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ButtonTheme(
        minWidth: 0,
        child: RaisedButton(
          elevation: isSelected ? 4 : 2,
          onPressed: () => onSelect(index),
          textColor: TinyColor(color).isLight() ? Colors.black : Colors.white,
          color: isSelected ? color : Theme.of(context).cardTheme.color,
          shape: const CircleBorder(),
          child: Text(weekdays[index - 1][0]),
        ),
      ),
    );
  }
}
