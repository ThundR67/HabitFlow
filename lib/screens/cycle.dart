import 'package:flutter/material.dart';
import 'package:habitflow/components/stats.dart';
import 'package:habitflow/resources/widgets.dart';

import 'package:provider/provider.dart';

import 'package:habitflow/blocs/current_bloc.dart';
import 'package:habitflow/blocs/habits_bloc.dart';
import 'package:habitflow/components/cycle_status.dart';
import 'package:habitflow/components/failures_expansion_tile_.dart';
import 'package:habitflow/components/habit_success_rates.dart';
import 'package:habitflow/models/cycle.dart';
import 'package:habitflow/models/habit.dart';
import 'package:habitflow/helpers/success_rate.dart';
import 'package:habitflow/resources/behaviour.dart';

/// Screen to show data about [cycle].
class CycleInfo extends StatelessWidget {
  /// Constructs.
  const CycleInfo(this._cycle);

  final Cycle _cycle;

  Map<String, double> _successRates(HabitsBloc bloc) {
    return <String, double>{
      for (Habit habit in bloc.habits.values)
        habit.name:
            calculateHabitSuccessRate(habit.id, _cycle.days.values.toList())
    };
  }

  Map<String, String> _habits(HabitsBloc bloc) {
    return <String, String>{
      for (Habit habit in bloc.habits.values) habit.id: habit.name
    };
  }

  @override
  Widget build(BuildContext context) {
    final HabitsBloc bloc = Provider.of<HabitsBloc>(context);

    if (bloc.habits == null) {
      return circularIndicator;
    }

    final List<int> stats = cycleStats(_cycle.days.values.toList());

    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: scrollPhysics,
          children: <Widget>[
            CycleStatus(cycle: _cycle),
            Stats(
              successesNum: stats[0],
              skipsNum: stats[1],
              failuresNum: stats[2],
            ),
            HabitSuccessRates(_successRates(bloc)),
            FailuresPanel(
              _cycle.days.values.toList(),
              _habits(bloc),
              Provider.of<CurrentBloc>(context),
            )
          ],
        ),
      ),
    );
  }
}
