import 'package:flutter/material.dart';
import 'package:habitflow/blocs/habits_bloc.dart';

import 'package:habitflow/components/percentage_indicator.dart';
import 'package:habitflow/resources/strings.dart';
import 'package:provider/provider.dart';

/// A expansion tile to show success rates of all habis.
class HabitSuccessRates extends StatelessWidget {
  /// Constructs.
  const HabitSuccessRates(this._successRates);

  final Map<String, double> _successRates;

  @override
  Widget build(BuildContext context) {
    final HabitsBloc bloc = Provider.of<HabitsBloc>(context);
    return ExpansionTile(
      title: Text(habits),
      children: [
        for (String id in _successRates.keys)
          _HabitAndRate(
            name: bloc.habits[id]?.name ?? habitDeleted,
            rate: _successRates[id],
          )
      ],
    );
  }
}

/// Shows habit name and success rate in a row.
class _HabitAndRate extends StatelessWidget {
  const _HabitAndRate({
    @required this.name,
    @required this.rate,
  });

  final String name;
  final double rate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 40,
        vertical: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Text(
              name,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          PercentageIndicator(
            value: rate,
            style: Theme.of(context).textTheme.subtitle1,
          )
        ],
      ),
    );
  }
}
