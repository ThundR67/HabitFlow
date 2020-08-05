import 'package:flutter/material.dart';

import 'package:habitflow/components/percentage_indicator.dart';
import 'package:habitflow/resources/strings.dart';

/// A expansion tile to show success rates of all habis.
class HabitSuccessRates extends StatelessWidget {
  /// Constructs.
  const HabitSuccessRates(
    this._successRates, {
    Key key,
  }) : super(key: key);

  final Map<String, double> _successRates;

  /// Returns widgets for expansion tile.
  List<Widget> _children(BuildContext context) {
    final List<Widget> output = <Widget>[];
    for (final String name in _successRates.keys) {
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
                name,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              PercentageIndicator(
                value: _successRates[name],
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
