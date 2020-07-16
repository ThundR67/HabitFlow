import 'package:flutter/material.dart';
import 'package:habitflow/models/dates.dart';

const List<String> _weekdays = <String>[
  'MON',
  'TUE',
  'WED',
  'THU',
  'FRI',
  'SAT',
  'SUN',
];

/// A widget to show info about a single date.
class _SingleDate extends StatelessWidget {
  /// Constructs.
  const _SingleDate(this._date, {Key key}) : super(key: key);

  final DateTime _date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Text(
            _weekdays[_date.weekday - 1],
            style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            _date.day.toString(),
            style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

/// An inline calendar.
class InlineCalendar extends StatelessWidget {
  /// Constructs.
  const InlineCalendar(this._start, this._end, {Key key}) : super(key: key);

  final DateTime _start;
  final DateTime _end;

  @override
  Widget build(BuildContext context) {
    /// TODO center this list view.
    final List<DateTime> dates = getDates(_start, _end);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Container(
        height: 54,
        alignment: Alignment.center,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: dates.length,
          itemBuilder: (BuildContext context, int index) {
            return _SingleDate(dates[index]);
          },
        ),
      ),
    );
  }
}
