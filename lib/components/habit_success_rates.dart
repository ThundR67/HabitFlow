import 'package:flutter/material.dart';
import 'package:habitflow/blocs/habits_bloc.dart';
import 'package:habitflow/models/day.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

/// A expansion tile to show success rates of all habis.
class HabitSuccessRates extends StatelessWidget {
  /// Constructs.
  const HabitSuccessRates(
    this._names,
    this._successRates, {
    Key key,
  }) : super(key: key);

  final List<String> _names;
  final List<double> _successRates;

  /// Returns widgets for expansion tile.
  List<Widget> _children() {
    final List<Widget> output = <Widget>[];
    for (int i = 0; i < _names.length; i++) {
      output.add(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                _names[i],
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              CircularPercentIndicator(
                radius: 56.0,
                lineWidth: 4.0,
                progressColor: Colors.greenAccent[400],
                percent: _successRates[i],
                backgroundColor: Colors.transparent,
                center: Text(
                  (_successRates[i] * 100).toStringAsFixed(1) + '%',
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
    return output;
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text('Habits'),
      children: _children(),
    );
  }
}
