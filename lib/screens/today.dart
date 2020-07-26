import 'package:flutter/material.dart';
import 'package:habitflow/blocs/current_cycle_bloc.dart';
import 'package:habitflow/blocs/cycles_bloc.dart';
import 'package:habitflow/blocs/habits_bloc.dart';
import 'package:habitflow/components/habits_list.dart';
import 'package:habitflow/components/inline_calendar.dart';
import 'package:habitflow/components/quote.dart';
import 'package:habitflow/models/dates.dart';

/// A screen to show user about todays information.
class Today extends StatelessWidget {
  /// Constructs.
  const Today(
    this._bloc,
    this._cyclesBloc,
    this._currentBloc,
    this._quoteID, {
    Key key,
  }) : super(key: key);

  final int _quoteID;

  final HabitsBloc _bloc;
  final CyclesBloc _cyclesBloc;
  final CurrentCycleBloc _currentBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Quote(_quoteID),
          InlineCalendar(
            parseDate(_currentBloc.current.start),
            parseDate(_currentBloc.current.end),
          ),
          HabitsList(_bloc.habits, _currentBloc.statuses),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/create_habit');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
