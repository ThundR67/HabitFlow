import 'package:flutter/material.dart';
import 'package:habitflow/components/neu_card.dart';
import 'package:habitflow/models/cycle.dart';
import 'package:habitflow/models/dates.dart';
import 'package:habitflow/models/success_rate.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

const List<String> _months = <String>[
  'JAN',
  'FEB',
  'MAR',
  'APR',
  'MAY',
  'JUN',
  'JUL',
  'AUG',
  'SEP',
  'OCT',
  'NOV',
  'DEC',
];

/// A card to show cycle data.
class CycleCard extends StatelessWidget {
  /// Constructs
  const CycleCard(this._cycle, {Key key}) : super(key: key);

  final Cycle _cycle;

  @override
  Widget build(BuildContext context) {
    final DateTime start = parseDate(_cycle.start);
    final DateTime end = parseDate(_cycle.end);
    final double successRate = calculateSuccessRate(_cycle.days);
    return NeuCard(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              _months[start.month - 1],
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
                (successRate * 100).toStringAsFixed(1),
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
