import 'package:flutter/material.dart';

import 'package:percent_indicator/circular_percent_indicator.dart';

import 'package:habitflow/helpers/time.dart';
import 'package:habitflow/helpers/dates.dart';
import 'package:habitflow/helpers/statistics.dart';
import 'package:habitflow/models/cycle.dart';
import 'package:habitflow/models/day.dart';
import 'package:habitflow/resources/strings.dart';

/// A horizontal calendar.
///
/// It displays each date and its success rate of [cycle].
class InlineCalendar extends StatelessWidget {
  /// Constructs.
  const InlineCalendar({@required this.cycle});

  /// Cyclof which calendar is shown.
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

/// A widget to show info about a single date of [InlineCalendar].
class _SingleDate extends StatelessWidget {
  /// Constructs.
  const _SingleDate({@required this.date, this.day});

  /// Date.
  final DateTime date;

  /// Info about the day.
  final Day day;

  @override
  Widget build(BuildContext context) {
    final double rate = day == null ? 0 : Statistics(days: {"": day}).totalRate;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: <Widget>[
          Text(
            weekdays[date.weekday - 1][0],
            style: Theme.of(context).textTheme.caption,
          ),
          const SizedBox(height: 4.0),
          CircularPercentIndicator(
            percent: rate,
            lineWidth: 3,
            radius: 40,
            backgroundColor: Colors.transparent,
            progressColor: Colors.greenAccent,
            center: Text(
              date.day.toString(),
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
        ],
      ),
    );
  }
}
