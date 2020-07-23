import 'package:flutter/material.dart';
import 'package:habitflow/components/neu_card.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

/// A card to show cycle data.
class CycleCard extends StatelessWidget {
  /// Constructs
  const CycleCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeuCard(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Jul',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '28 - 1',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            CircularPercentIndicator(
              radius: 64.0,
              lineWidth: 4.0,
              progressColor: Colors.greenAccent[400],
              percent: 0.28,
              backgroundColor: Colors.transparent,
              center: Text(
                '28.0%',
                style: TextStyle(
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
