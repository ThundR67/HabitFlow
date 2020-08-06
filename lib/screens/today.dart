import 'package:flutter/material.dart';

import 'package:habitflow/blocs/current_cycle_bloc.dart';
import 'package:habitflow/blocs/habits_bloc.dart';
import 'package:habitflow/components/habits_list.dart';
import 'package:habitflow/components/inline_calendar.dart';
import 'package:habitflow/resources/behaviour.dart';
import 'package:habitflow/resources/icons.dart';
import 'package:habitflow/resources/strings.dart';

/// A screen to show user about todays information.
class Today extends StatelessWidget {
  /// Constructs.
  const Today(
    this._bloc,
    this._currentBloc, {
    Key key,
  }) : super(key: key);

  final HabitsBloc _bloc;
  final CurrentCycleBloc _currentBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.cover,
                height: 44,
              ),
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.headline5,
            )
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          InlineCalendar(cycle: _currentBloc.current),
          HabitsList(
            habits: _bloc.habits,
            statuses: _currentBloc.statuses,
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
