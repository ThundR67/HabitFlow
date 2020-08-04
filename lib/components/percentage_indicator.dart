import 'package:flutter/material.dart';

import 'package:percent_indicator/circular_percent_indicator.dart';

/// A widget to show percentage with indicator.
class PercentageIndicator extends StatelessWidget {
  /// Constructs
  const PercentageIndicator({this.value, this.style});

  /// The percentage value.
  final double value;

  /// Style of text.
  final TextStyle style;

  /// Returns string representation of [value].
  String _toString() {
    if (value.roundToDouble() == value) {
      return (value.round() * 100).toString() + '%';
    }
    return (value * 100).toStringAsFixed(1) + '%';
  }

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: style.fontSize + 56,
      lineWidth: 4.0,
      progressColor: Colors.greenAccent[400],
      percent: value,
      backgroundColor: Colors.transparent,
      center: Text(
        _toString(),
        style: style,
      ),
    );
  }
}
