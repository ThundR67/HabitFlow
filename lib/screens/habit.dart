import 'package:flutter/material.dart';
import 'package:habitflow/blocs/current_bloc.dart';
import 'package:habitflow/components/recent_failures.dart';
import 'package:habitflow/components/stats.dart';
import 'package:habitflow/helpers/success_rate.dart';
import 'package:habitflow/models/habit.dart';
import 'package:habitflow/resources/strings.dart';
import 'package:provider/provider.dart';

/// A widget to show notification time.
class _Time extends StatelessWidget {
  const _Time(this._time);

  final TimeOfDay _time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$notificationTime: ',
            style: Theme.of(context).textTheme.headline6,
          ),
          Text(
            _time.format(context),
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      ),
    );
  }
}

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
            if (_habit.goal.notificationTimes.isNotEmpty)
              _Time(_habit.goal.notificationTimes[0]),
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
            const SizedBox(height: 24.0),
            if (recentFailures.isNotEmpty) RecentFailures(recentFailures),
          ],
        ),
      ),
    );
  }
}
