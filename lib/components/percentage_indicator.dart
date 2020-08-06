import 'package:flutter/material.dart';

import 'package:percent_indicator/circular_percent_indicator.dart';

/// A widget to show percentage with circular percentage indicator.
class PercentageIndicator extends StatelessWidget {
  /// Constructs
  const PercentageIndicator({@required this.value, @required this.style});

  /// The percentage value.
  final double value;

  /// Style of text.
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    String strValue = (value * 100).toStringAsFixed(1);
    if (value.roundToDouble() == value) {
      strValue = (value.round() * 100).toString();
    }

    return CircularPercentIndicator(
      radius: style.fontSize + 56,
      lineWidth: 4.0,
      progressColor: Colors.greenAccent[400],
      percent: value,
      backgroundColor: Colors.transparent,
      center: Text(
        '$strValue%',
        style: style,
      ),
    );
  }
}
