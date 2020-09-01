import 'package:flutter/material.dart';
import 'package:habitflow/resources/strings.dart';

/// A picker to allow user to pick weekdays.
///
/// [onChange] will run when user does certain selection.
/// [onChange] will be provided with list of days index selected by user.
/// Index of monday starts with 1 (Same as of [DateTime]).
class WeekdaysPicker extends StatefulWidget {
  /// Constructs.
  const WeekdaysPicker({@required this.onChange, @required this.color});

  /// Function to run when weekdays change.
  final Function(List<int>) onChange;

  /// Color of the widget.
  final Color color;

  @override
  _WeekdaysPickerState createState() => _WeekdaysPickerState();
}

class _WeekdaysPickerState extends State<WeekdaysPicker> {
  final List<int> _daysSelected = [];

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
  Widget build(BuildContext context) {
    return Container(
      height: 40,
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
    return Container(
      height: 40,
      width: 40,
      child: InkWell(
        onTap: () => onSelect(index),
        child: Card(
          elevation: isSelected ? 8 : 2,
          color: isSelected ? activeColor : Theme.of(context).cardColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(100),
            ),
          ),
          child: Center(
            child: Text(weekdays[index - 1][0]),
          ),
        ),
      ),
    );
  }
}
