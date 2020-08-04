import 'package:flutter/material.dart';

import 'package:percent_indicator/circular_percent_indicator.dart';

import 'package:habitflow/components/percentage_indicator.dart';
import 'package:habitflow/models/day.dart';
import 'package:habitflow/resources/strings.dart';

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
  List<Widget> _children(BuildContext context) {
    final List<Widget> output = <Widget>[];
    for (int i = 0; i < _names.length; i++) {
      output.add(
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                _names[i],
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              PercentageIndicator(
                value: _successRates[i],
                style: Theme.of(context).textTheme.subtitle1,
              )
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
      title: Text(habits),
      children: _children(context),
    );
  }
}
