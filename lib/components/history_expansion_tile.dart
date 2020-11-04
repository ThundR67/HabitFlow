import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:habitflow/blocs/current_bloc.dart';
import 'package:habitflow/blocs/habits_bloc.dart';
import 'package:habitflow/components/failure_reason_sheet.dart';
import 'package:habitflow/helpers/scaffold.dart';
import 'package:habitflow/helpers/time.dart';
import 'package:habitflow/models/day.dart';
import 'package:habitflow/models/status.dart';
import 'package:habitflow/resources/icons.dart';
import 'package:habitflow/resources/strings.dart';

/// Shows history of successes, skips, or failures with reason.
class HistoryExpansionTile extends StatelessWidget {
  /// Constructs.
  const HistoryExpansionTile({
    @required this.status,
    @required this.days,
    @required this.isEnded,
  });

  /// Status to show list of.
  final Status status;

  /// Days.
  final List<Day> days;

  /// Is The Cycle Ended.
  final bool isEnded;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(status.category),
      childrenPadding: const EdgeInsets.all(16.0),
      children: [
        for (final Day day in days)
          _DayHistory(
            status: status,
            day: day,
            isEnded: isEnded,
          ),
      ],
    );
  }
}

/// Shows history of [day].
class _DayHistory extends StatelessWidget {
  const _DayHistory({
    @required this.day,
    @required this.status,
    @required this.isEnded,
  }) : _isFailure = status == Status.failed;

  final Day day;
  final Status status;
  final bool _isFailure;
  final bool isEnded;

  /// All more option buttons.
  List<PopupMenuItem<int>> _menuOptions() {
    return <PopupMenuItem<int>>[
      if (status != Status.skipped)
        PopupMenuItem<int>(
          value: 0,
          child: Text(markSkip),
        ),
      if (status != Status.done)
        PopupMenuItem<int>(
          value: 1,
          child: Text(markDone),
        ),
      PopupMenuItem<int>(
        value: 2,
        child: Text(_isFailure ? updateReason : markFail),
      ),
    ];
  }

  /// Gets list of habit ids from [day] based on [status].
  List<String> _habits(Day day) {
    switch (status) {
      case Status.done:
        return day.successes;
      case Status.skipped:
        return day.skips;
      case Status.failed:
        return day.failures.keys.toList();
      default:
        return [];
    }
  }

  /// Shows failure reason sheet.
  void _showFailureReasonSheet(BuildContext context, String id) {
    bottomsheet(
      context,
      FailureReasonSheet(
        id: id,
        date: day.date.date(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> habits = _habits(day);
    if (habits.isEmpty) return Container();

    final HabitsBloc bloc = Provider.of<HabitsBloc>(context);
    final CurrentBloc currentBloc = Provider.of<CurrentBloc>(context);
    final DateTime date = day.date.date();

    return Column(
      children: [
        Text(
          '${weekdays[date.weekday - 1]} ${date.day} ${months[date.month - 1]}',
          style: Theme.of(context).textTheme.subtitle1,
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: habits.length,
          itemBuilder: (context, index) {
            final String id = habits[index];

            return ListTile(
              title: Text(bloc.habits[id]?.name ?? habitDeleted),
              subtitle: _isFailure ? Text(day.failures[id]) : null,
              trailing: isEnded
                  ? null
                  : PopupMenuButton<dynamic>(
                      onSelected: (dynamic value) {
                        if (value == 0) {
                          currentBloc.mark(id, Status.skipped, date: date);
                        } else if (value == 1) {
                          currentBloc.mark(id, Status.done, date: date);
                        } else if (value == 2) {
                          _showFailureReasonSheet(context, id);
                        }
                      },
                      itemBuilder: (_) {
                        return _menuOptions();
                      },
                      child: const Icon(moreIcon),
                    ),
            );
          },
        ),
      ],
    );
  }
}
