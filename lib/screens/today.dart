import 'package:flutter/material.dart';

import 'package:habitflow/blocs/current_bloc.dart';
import 'package:habitflow/blocs/habits_bloc.dart';
import 'package:habitflow/components/habits_list.dart';
import 'package:habitflow/components/inline_calendar.dart';
import 'package:habitflow/components/main_drawer.dart';
import 'package:habitflow/resources/behaviour.dart';
import 'package:habitflow/resources/icons.dart';
import 'package:habitflow/resources/routes.dart';
import 'package:habitflow/resources/strings.dart';
import 'package:habitflow/resources/widgets.dart';
import 'package:provider/provider.dart';

/// A screen to show user about todays information.
class Today extends StatelessWidget {
  /// Constructs.
  const Today();

  @override
  Widget build(BuildContext context) {
    final HabitsBloc habitsBloc = Provider.of<HabitsBloc>(context);
    final CurrentBloc currentBloc = Provider.of<CurrentBloc>(context);

    if (habitsBloc.habits == null || currentBloc.statuses == null) {
      return circularIndicator;
    }

    return Scaffold(
      drawer: const MainDrawer(),
      appBar: AppBar(
        title: const _Title(),
        //automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          InlineCalendar(cycle: currentBloc.current),
          Expanded(
            child: SingleChildScrollView(
              physics: scrollPhysics,
              child: HabitsList(
                habits: habitsBloc.habits,
                statuses: currentBloc.statuses,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: createHabitRoute,
        onPressed: () => Navigator.of(context).pushNamed(createHabitRoute),
        child: const Icon(addIcon),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      //mainAxisAlignment: MainAxisAlignment.center,

      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.cover,
            height: 32,
          ),
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.headline5,
          textAlign: TextAlign.center,
        ),
        const SizedBox(width: 40)
      ],
    );
  }
}
