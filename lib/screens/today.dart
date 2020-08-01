import 'package:flutter/material.dart';

import 'package:habitflow/blocs/current_cycle_bloc.dart';
import 'package:habitflow/blocs/habits_bloc.dart';
import 'package:habitflow/components/habits_list.dart';
import 'package:habitflow/components/inline_calendar.dart';
import 'package:habitflow/components/quote.dart';
import 'package:habitflow/resources/behaviour.dart';
import 'package:habitflow/resources/icons.dart';

/// A screen to show user about todays information.
class Today extends StatelessWidget {
  /// Constructs.
  const Today(
    this._bloc,
    this._currentBloc,
    this._quoteID, {
    Key key,
  }) : super(key: key);

  final int _quoteID;

  final HabitsBloc _bloc;
  final CurrentCycleBloc _currentBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Quote(_quoteID),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.grey[850],
      ),
      body: SingleChildScrollView(
        physics: scrollPhysics,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            InlineCalendar(_currentBloc.current),
            HabitsList(_bloc.habits, _currentBloc.statuses),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'create_habit',
        onPressed: () {
          Navigator.of(context).pushNamed('/create_habit');
        },
        child: const Icon(addIcon),
      ),
    );
  }
}
