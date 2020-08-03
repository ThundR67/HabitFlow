import 'package:flutter/material.dart';

import 'package:percent_indicator/circular_percent_indicator.dart';

import 'package:habitflow/models/cycle.dart';
import 'package:habitflow/models/dates.dart';
import 'package:habitflow/models/success_rate.dart';
import 'package:habitflow/resources/strings.dart';

/// A widget to display status of cycle.
class CycleStatus extends StatelessWidget {
  /// Constructs.
  const CycleStatus(this._cycle, {Key key}) : super(key: key);

  final Cycle _cycle;

  @override
  Widget build(BuildContext context) {
    final DateTime start = parseDate(_cycle.start);
    final DateTime end = parseDate(_cycle.end);
    final double successRate = calculateSuccessRate(_cycle.days);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          months[start.month - 1],
          style: Theme.of(context).textTheme.headline5,
        ),
        Text(
          '${start.day} - ${end.day}',
          style: Theme.of(context).textTheme.headline5,
        ),
        CircularPercentIndicator(
          radius: 72.0,
          lineWidth: 4.0,
          progressColor: Colors.greenAccent[400],
          percent: successRate,
          backgroundColor: Colors.transparent,
          center: Text(
            (successRate * 100).toStringAsFixed(1) + '%',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ],
    );
  }
}
