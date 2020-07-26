import 'package:flutter/material.dart';
import 'package:habitflow/models/cycle.dart';
import 'package:habitflow/models/dates.dart';
import 'package:habitflow/models/day.dart';
import 'package:habitflow/models/success_rate.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

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
  const _SingleDate(this._date, this._day, {Key key}) : super(key: key);

  final DateTime _date;
  final Day _day;

  @override
  Widget build(BuildContext context) {
    double successRate = 0;
    if (_day != null) {
      successRate = calculateSuccessRate(<Day>[_day]);
    }

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
          CircularPercentIndicator(
            radius: 32.0,
            lineWidth: 2.0,
            progressColor: Colors.greenAccent,
            backgroundColor: Colors.transparent,
            percent: successRate,
            center: Text(
              _date.day.toString(),
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
              ),
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
  const InlineCalendar(this._cycle, {Key key}) : super(key: key);

  final Cycle _cycle;

  @override
  Widget build(BuildContext context) {
    /// TODO center this list view.
    final List<DateTime> dates = getDates(
      parseDate(_cycle.start),
      parseDate(_cycle.end),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: 70,
        alignment: Alignment.center,
        child: Center(
          child: _cycle.start == _cycle.end
              ? const CircularProgressIndicator()
              : ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: dates.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _SingleDate(
                      dates[index],
                      getDay(_cycle.days, dates[index]),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
