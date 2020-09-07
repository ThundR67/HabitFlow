import 'package:flutter/material.dart';
import 'package:habitflow/components/history_expansion_tile.dart';

import 'package:provider/provider.dart';

import 'package:habitflow/blocs/current_bloc.dart';
import 'package:habitflow/blocs/habits_bloc.dart';
import 'package:habitflow/components/cycle_header.dart';
import 'package:habitflow/components/failures_expansion_tile_1.dart';
import 'package:habitflow/components/habit_success_rates.dart';
import 'package:habitflow/components/stats.dart';
import 'package:habitflow/helpers/statistics.dart';
import 'package:habitflow/models/cycle.dart';
import 'package:habitflow/models/habit.dart';
import 'package:habitflow/resources/strings.dart';

/// Screen to show data about [cycle].
class CycleInfo extends StatelessWidget {
  /// Constructs.
  const CycleInfo(this._cycle);

  final Cycle _cycle;

  Map<String, double> _successRates(HabitsBloc bloc) {
    final Map<String, double> successRates = {};
    final List<String> habitIds = [];
    for (final day in _cycle.days.values) {
      habitIds.addAll(day.activeHabits);
    }

    for (final id in habitIds.toSet().toList()) {
      successRates[id] = Statistics(
        days: _cycle.days,
        habits: [id],
      ).successRate;
    }
    return successRates;
  }

  Map<String, String> _habits(HabitsBloc bloc) {
    return <String, String>{
      for (Habit habit in bloc.habits.values) habit.id: habit.name
    };
  }

  @override
  Widget build(BuildContext context) {
    final HabitsBloc bloc = Provider.of<HabitsBloc>(context);

    final Statistics stats = Statistics(days: _cycle.days);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          cycleInfo,
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            CycleHeader(cycle: _cycle),
            const SizedBox(height: 16.0),
            Stats(stats),
            const SizedBox(height: 16.0),
            HabitSuccessRates(_successRates(bloc)),
            //FailuresPanel(
            //_cycle.days.values.toList(),
            //_habits(bloc),
            //Provider.of<CurrentBloc>(context),
            //),
            HistoryExpansionTile(),
          ],
        ),
      ),
    );
  }
}
