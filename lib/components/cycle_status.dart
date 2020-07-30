import 'package:flutter/material.dart';
import 'package:habitflow/models/cycle.dart';
import 'package:habitflow/models/dates.dart';
import 'package:habitflow/models/success_rate.dart';
import 'package:habitflow/resources/strings.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

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
          style: const TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '${start.day} - ${end.day}',
          style: const TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        CircularPercentIndicator(
          radius: 64.0,
          lineWidth: 4.0,
          progressColor: Colors.greenAccent[400],
          percent: successRate,
          backgroundColor: Colors.transparent,
          center: Text(
            (successRate * 100).toStringAsFixed(1) + '%',
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
