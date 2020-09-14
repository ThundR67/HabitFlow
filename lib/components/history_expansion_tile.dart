import 'package:flutter/material.dart';
import 'package:habitflow/blocs/current_bloc.dart';
import 'package:habitflow/blocs/habits_bloc.dart';
import 'package:habitflow/components/failure_reason_sheet.dart';
import 'package:habitflow/models/day.dart';
import 'package:habitflow/models/status.dart';
import 'package:habitflow/resources/icons.dart';
import 'package:habitflow/resources/strings.dart';
import 'package:habitflow/helpers/time.dart';
import 'package:provider/provider.dart';

/// Shows history of successes, skips, or failures with reason.
class HistoryExpansionTile extends StatelessWidget {
  /// Constructs.
  const HistoryExpansionTile({
    @required this.status,
    @required this.days,
  });

  /// Status to show list of.
  final Status status;

  /// Days.
  final List<Day> days;

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
  }) : _isFailure = status == Status.failed;

  final Day day;
  final Status status;
  final bool _isFailure;

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
      if (!_isFailure)
        PopupMenuItem<int>(
          value: 2,
          child: Text(markFail),
        ),
      if (_isFailure)
        PopupMenuItem<int>(
          value: 3,
          child: Text(updateReason),
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

      /// TODO
    }
  }

  /// Shows failure reason sheet.
  void _showFailureReasonSheet(BuildContext context, String id) {
    Scaffold.of(context).showBottomSheet<FailureReasonSheet>(
      (BuildContext context) => FailureReasonSheet(
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
          itemCount: habits.length,
          itemBuilder: (context, index) {
            /// Getting the habit name.
            String habitName = habitDeleted;
            if (bloc.habits.containsKey(habits[index])) {
              habitName = bloc.habits[habits[index]].name;
            }

            return ListTile(
              title: Text(habitName),
              trailing: PopupMenuButton<dynamic>(
                elevation: 8,
                onSelected: (dynamic value) {
                  if (value == 0) {
                    currentBloc.mark(habits[index], Status.skipped, date: date);
                  } else if (value == 1) {
                    currentBloc.mark(habits[index], Status.done, date: date);
                  } else if (value == 2 || value == 3) {
                    _showFailureReasonSheet(context, habits[index]);
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
