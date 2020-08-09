import 'package:flutter/material.dart';
import 'package:habitflow/blocs/current_bloc.dart';
import 'package:habitflow/blocs/habits_bloc.dart';
import 'package:habitflow/components/recent_failures.dart';
import 'package:habitflow/components/stats.dart';
import 'package:habitflow/helpers/success_rate.dart';
import 'package:habitflow/models/habit.dart';
import 'package:habitflow/resources/icons.dart';
import 'package:habitflow/resources/strings.dart';
import 'package:provider/provider.dart';

/// Widget to show info in key and value.
class _KeyValue extends StatelessWidget {
  const _KeyValue({@required this.keyText, @required this.valueText});

  /// Key.
  final String keyText;

  /// Value.
  final String valueText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$keyText: ',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            valueText,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}

/// Widget to display habit info.
class _Info extends StatelessWidget {
  const _Info(this._habit);

  final Habit _habit;

  /// Returns initials of all active weekdays.
  List<String> _days() {
    final List<String> output = [];
    for (final int day in _habit.goal.activeDays) {
      output.add(weekdays[day - 1][0]);
    }
    return output;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          habitInfo,
          style: Theme.of(context).textTheme.headline5,
        ),
        if (_habit.goal.notificationTimes.isNotEmpty)
          _KeyValue(
            keyText: notificationTime,
            valueText: _habit.goal.notificationTimes[0].format(context),
          ),
        _KeyValue(keyText: activeDays, valueText: _days().join(', ')),
      ],
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

    final HabitsBloc bloc = Provider.of<HabitsBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _habit.name,
          style: Theme.of(context).textTheme.headline5,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            icon: Icon(
              deleteIcon,
              color: Theme.of(context).iconTheme.color,
            ),
            onPressed: () {
              bloc.delete(_habit);
              Navigator.of(context).pop();
            },
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            _Info(_habit),
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
            const SizedBox(height: 24.0),
            if (recentFailures.isNotEmpty) RecentFailures(recentFailures),
          ],
        ),
      ),
    );
  }
}
