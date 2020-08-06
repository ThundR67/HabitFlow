import 'package:flutter/material.dart';
import 'package:habitflow/components/percentage_indicator.dart';
import 'package:habitflow/helpers/date_format.dart';
import 'package:habitflow/helpers/dates.dart';

import 'package:habitflow/models/cycle.dart';
import 'package:habitflow/models/day.dart';
import 'package:habitflow/helpers/success_rate.dart';
import 'package:habitflow/resources/behaviour.dart';
import 'package:habitflow/resources/strings.dart';

/// A widget to show info about a single date.
class _SingleDate extends StatelessWidget {
  /// Constructs.
  const _SingleDate({@required this.day});

  /// Info about the day.
  final Day day;

  @override
  Widget build(BuildContext context) {
    final DateTime date = parseDate(day.date);
    final double successRate = calculateSuccessRate(<Day>[day]);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Text(
            weekdays[date.weekday - 1][0],
            style: Theme.of(context).textTheme.caption,
          ),
          const SizedBox(height: 4.0),
          PercentageIndicator(
            value: successRate,
            style: Theme.of(context).textTheme.headline6,
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

  @override
  Widget build(BuildContext context) {
    if (cycle == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final List<DateTime> dates = datesList(
      parseDate(cycle.start),
      parseDate(cycle.end),
    );

    return Center(
      child: ListView.builder(
        physics: scrollPhysics,
        scrollDirection: Axis.horizontal,
        itemCount: dates.length,
        itemBuilder: (_, int index) => _SingleDate(day: cycle.days[index]),
      ),
    );
  }
}
