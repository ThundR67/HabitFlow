import 'package:flutter/material.dart';

import 'package:percent_indicator/circular_percent_indicator.dart';

import 'package:habitflow/models/cycle.dart';
import 'package:habitflow/models/dates.dart';
import 'package:habitflow/models/day.dart';
import 'package:habitflow/models/success_rate.dart';
import 'package:habitflow/resources/behaviour.dart';
import 'package:habitflow/resources/strings.dart';

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
            weekdays[_date.weekday - 1][0],
            style: Theme.of(context).textTheme.caption,
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
              style: Theme.of(context).textTheme.headline6,
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

  /// Return widgets for all dates.
  List<Widget> _dates() {
    final List<Widget> output = <Widget>[];
    final List<DateTime> dates = getDates(
      parseDate(_cycle.start),
      parseDate(_cycle.end),
    );
    for (final DateTime date in dates) {
      output.add(_SingleDate(date, getDay(_cycle.days, date)));
    }
    return output;
  }

  @override
  Widget build(BuildContext context) {
    if (_cycle.start == _cycle.end) {
      return const Center(child: CircularProgressIndicator());
    }

    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SingleChildScrollView(
          physics: scrollPhysics,
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _dates(),
          ),
        ),
      ),
    );
  }
}
