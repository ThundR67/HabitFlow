import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:habitflow/blocs/current_cycle_bloc.dart';
import 'package:habitflow/blocs/habits_bloc.dart';
import 'package:habitflow/components/cycle_status.dart';
import 'package:habitflow/components/failures_expansion_tile_.dart';
import 'package:habitflow/components/habit_success_rates.dart';
import 'package:habitflow/models/cycle.dart';
import 'package:habitflow/models/habit.dart';
import 'package:habitflow/helpers/success_rate.dart';
import 'package:habitflow/resources/behaviour.dart';

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

    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: scrollPhysics,
          children: <Widget>[
            CycleStatus(cycle: _cycle),
            HabitSuccessRates(
              <String, double>{
                for (Habit habit in bloc.habits.values)
                  habit.name: calculateHabitSuccessRate(
                      habit.id, _cycle.days.values.toList())
              },
            ),
            FailuresPanel(
              _cycle.days.values.toList(),
              <String, String>{
                for (Habit habit in bloc.habits.values) habit.id: habit.name
              },
              Provider.of<CurrentCycleBloc>(context),
            )
          ],
        ),
      ),
    );
  }
}
