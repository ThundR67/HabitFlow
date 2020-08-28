import 'package:flutter/material.dart';

import 'package:habitflow/components/percentage_indicator.dart';
import 'package:habitflow/helpers/time.dart';
import 'package:habitflow/helpers/statistics.dart';
import 'package:habitflow/models/cycle.dart';
import 'package:habitflow/resources/strings.dart';

/// A widget to display basic info about cycle.
class CycleHeader extends StatelessWidget {
  /// Constructs.
  const CycleHeader({@required this.cycle});

  /// Cycle to show data of.
  final Cycle cycle;

  @override
  Widget build(BuildContext context) {
    final DateTime start = cycle.start.date();
    final DateTime end = cycle.end.date();
    final Statistics stats = Statistics(days: cycle.days);

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
          value: stats.successRate,
          style: Theme.of(context).textTheme.headline5,
        )
      ],
    );
  }
}
