import 'package:flutter/material.dart';

import 'package:habitflow/helpers/date_format.dart';
import 'package:habitflow/helpers/dates.dart';

import 'package:habitflow/models/cycle.dart';
import 'package:habitflow/models/day.dart';
import 'package:habitflow/helpers/success_rate.dart';
import 'package:habitflow/resources/behaviour.dart';
import 'package:habitflow/resources/strings.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

/// A widget to show info about a single date.
class _SingleDate extends StatelessWidget {
  /// Constructs.
  const _SingleDate({@required this.date, @required this.day});

  /// Info about the day.
  final Day day;

  /// Date of day.
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    double successRate = 0;
    if (day != null) {
      successRate = calculateSuccessRate(<Day>[day]);
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Text(
            weekdays[date.weekday - 1][0],
            style: Theme.of(context).textTheme.caption,
          ),
          const SizedBox(height: 4.0),
          CircularPercentIndicator(
            percent: successRate,
            lineWidth: 3,
            radius: 38,
            backgroundColor: Colors.transparent,
            progressColor: Colors.greenAccent,
            center: Text(
              date.day.toString(),
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
  const InlineCalendar({@required this.cycle});

  /// Cycle to get data.
  final Cycle cycle;

  /// Returns widget for all days.
  List<Widget> _datesCards() {
    final List<Widget> output = <Widget>[];
    final List<DateTime> dates = datesList(
      parseDate(cycle.start),
      parseDate(cycle.end),
    );

    for (final DateTime date in dates) {
      output.add(
        _SingleDate(
          date: date,
          day: cycle.days[formatDate(date)],
        ),
      );
    }

    return output;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SingleChildScrollView(
          physics: scrollPhysics,
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _datesCards(),
          ),
        ),
      ),
    );
  }
}
