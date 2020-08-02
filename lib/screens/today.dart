import 'package:flutter/material.dart';

import 'package:habitflow/blocs/current_cycle_bloc.dart';
import 'package:habitflow/blocs/habits_bloc.dart';
import 'package:habitflow/components/habits_list.dart';
import 'package:habitflow/components/inline_calendar.dart';
import 'package:habitflow/components/quote.dart';
import 'package:habitflow/resources/behaviour.dart';
import 'package:habitflow/resources/icons.dart';
import 'package:habitflow/resources/strings.dart';

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
        title: Text(
          title,
          style: Theme.of(context).textTheme.headline5,
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          InlineCalendar(_currentBloc.current),
          Expanded(
            child: SingleChildScrollView(
              physics: scrollPhysics,
              child: HabitsList(_bloc.habits, _currentBloc.statuses),
            ),
          ),
        ],
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
