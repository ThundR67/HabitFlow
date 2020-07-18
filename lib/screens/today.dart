import 'package:flutter/material.dart';
import 'package:habitflow/blocs/habits_bloc.dart';
import 'package:habitflow/components/habits_list.dart';
import 'package:habitflow/components/inline_calendar.dart';
import 'package:habitflow/components/quote.dart';

/// A screen to show user about todays information.
class Today extends StatelessWidget {
  /// Constructs.
  const Today(this._bloc, this._quoteID, {Key key}) : super(key: key);

  final int _quoteID;

  final HabitsBloc _bloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Quote(_quoteID),
          InlineCalendar(
            DateTime.now(),
            DateTime.now().add(const Duration(days: 15)),
          ),
          HabitsList(_bloc.habits, _bloc.statuses),
        ],
      ),
    );
  }
}
