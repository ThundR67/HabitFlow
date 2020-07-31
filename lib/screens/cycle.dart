import 'package:flutter/material.dart';
import 'package:habitflow/resources/behaviour.dart';

import 'package:provider/provider.dart';

import 'package:habitflow/blocs/current_cycle_bloc.dart';
import 'package:habitflow/blocs/habits_bloc.dart';
import 'package:habitflow/components/cycle_status.dart';
import 'package:habitflow/components/failures_expansion_tile_.dart';
import 'package:habitflow/components/habit_success_rates.dart';
import 'package:habitflow/models/cycle.dart';
import 'package:habitflow/models/habit.dart';
import 'package:habitflow/models/success_rate.dart';

/// Shows data about a cycle.
class CycleInfo extends StatelessWidget {
  /// Constructs.
  const CycleInfo(this._cycle, {Key key}) : super(key: key);

  final Cycle _cycle;

  @override
  Widget build(BuildContext context) {
    final HabitsBloc bloc = Provider.of<HabitsBloc>(context);
    if (bloc.habits.isEmpty) {
      return const LinearProgressIndicator();
    }
    final Map<String, String> idToName = <String, String>{
      for (Habit habit in bloc.habits) habit.id: habit.name
    };

    return SafeArea(
      child: Scaffold(
        body: ListView(
          physics: scrollPhysics,
          children: <Widget>[
            CycleStatus(_cycle),
            HabitSuccessRates(
              bloc.habits.map((Habit e) => e.name).toList(),
              bloc.habits
                  .map(
                    (Habit e) => calculateHabitSuccessRate(e.id, _cycle.days),
                  )
                  .toList(),
            ),
            FailuresPanel(
              _cycle.days,
              idToName,
              Provider.of<CurrentCycleBloc>(context),
            )
          ],
        ),
      ),
    );
  }
}
