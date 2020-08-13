import 'package:flutter/material.dart';
import 'package:habitflow/helpers/date_format.dart';

import 'package:habitflow/components/percentage_indicator.dart';
import 'package:habitflow/models/cycle.dart';
import 'package:habitflow/helpers/success_rate.dart';
import 'package:habitflow/resources/strings.dart';

/// A widget to display status of cycle.
class CycleStatus extends StatelessWidget {
  /// Constructs.
  const CycleStatus({@required this.cycle});

  /// Cycle to show data of.
  final Cycle cycle;

  @override
  Widget build(BuildContext context) {
    final DateTime start = parseDate(cycle.start);
    final DateTime end = parseDate(cycle.end);
    final double successRate = calculateSuccessRate(cycle.days.values.toList());

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          months[start.month - 1].substring(0, 3),
          style: Theme.of(context).textTheme.headline5,
        ),
        Text(
          '${start.day} - ${end.day}',
          style: Theme.of(context).textTheme.headline5,
        ),
        PercentageIndicator(
          value: successRate,
          style: Theme.of(context).textTheme.headline5,
        )
      ],
    );
  }
}
