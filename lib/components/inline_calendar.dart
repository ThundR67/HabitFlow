import 'package:flutter/material.dart';

import 'package:percent_indicator/circular_percent_indicator.dart';

import 'package:habitflow/helpers/time.dart';
import 'package:habitflow/helpers/dates.dart';
import 'package:habitflow/helpers/statistics.dart';
import 'package:habitflow/models/cycle.dart';
import 'package:habitflow/models/day.dart';
import 'package:habitflow/resources/behaviour.dart';
import 'package:habitflow/resources/strings.dart';

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
    Widget text = Text(
      date.day.toString(),
      style: Theme.of(context).textTheme.subtitle1,
    );

    if (day.activeHabits != null) {
      text = CircularPercentIndicator(
        percent: Statistics(days: {"": day}).successRate,
        lineWidth: 3,
        radius: 40,
        backgroundColor: Colors.transparent,
        progressColor: Colors.greenAccent,
        center: text,
      );
    }

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: <Widget>[
          Text(
            weekdays[date.weekday - 1][0],
            style: Theme.of(context).textTheme.caption,
          ),
          const SizedBox(height: 4.0),
          text,
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

  @override
  Widget build(BuildContext context) {
    final List<DateTime> dates = datesList(
      cycle.start.date(),
      cycle.end.date(),
    );

    return Container(
      height: 72,
      alignment: Alignment.center,
      child: ListView.builder(
        itemExtent: 64,
        cacheExtent: 0,
        physics: scrollPhysics,
        scrollDirection: Axis.horizontal,
        itemCount: dates.length,
        itemBuilder: (context, index) {
          final DateTime date = dates[index];
          return _SingleDate(
            date: date,
            day: cycle.days[date.format()],
          );
        },
      ),
    );
  }
}
