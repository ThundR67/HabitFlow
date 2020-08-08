import 'package:flutter/material.dart';
import 'package:habitflow/blocs/current_bloc.dart';
import 'package:habitflow/components/recent_failures.dart';
import 'package:habitflow/components/stats.dart';
import 'package:habitflow/helpers/success_rate.dart';
import 'package:habitflow/models/habit.dart';
import 'package:habitflow/resources/strings.dart';
import 'package:provider/provider.dart';

/// A screen to show info about [habit].
class HabitInfo extends StatelessWidget {
  /// Constructs.
  const HabitInfo(this._habit);

  final Habit _habit;

  @override
  Widget build(BuildContext context) {
    final CurrentBloc currentBloc = Provider.of<CurrentBloc>(context);
    final List<String> recentFailures = getRecentFailures(
      _habit.id,
      currentBloc.current.days.values.toList(),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _habit.name,
          style: Theme.of(context).textTheme.headline5,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24.0),
            Stats(
              successesNum: successesAmount(
                _habit.id,
                currentBloc.current.days.values.toList(),
              ),
              skipsNum: skipsAmount(
                _habit.id,
                currentBloc.current.days.values.toList(),
              ),
              failuresNum: failureAmount(
                _habit.id,
                currentBloc.current.days.values.toList(),
              ),
            ),
            const SizedBox(height: 64.0),
            if (recentFailures.isNotEmpty) RecentFailures(recentFailures),
          ],
        ),
      ),
    );
  }
}
