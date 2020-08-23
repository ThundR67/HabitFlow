import 'package:flutter/material.dart';

import 'package:habitflow/blocs/current_bloc.dart';
import 'package:habitflow/components/failure_reason_sheet.dart';
import 'package:habitflow/helpers/time.dart';
import 'package:habitflow/models/day.dart';
import 'package:habitflow/models/status.dart';
import 'package:habitflow/resources/icons.dart';
import 'package:habitflow/resources/strings.dart';

/// A widget to show all failures of a day.
class _DaysFailures extends StatelessWidget {
  const _DaysFailures(this._day, this._idToName, this._bloc);

  final Day _day;
  final Map<String, String> _idToName;
  final CurrentBloc _bloc;

  /// Shows failure reason sheet.
  void _showFailureReasonSheet(BuildContext context, String id, String date) {
    Scaffold.of(context).showBottomSheet<FailureReasonSheet>(
      (BuildContext context) => FailureReasonSheet(
        id: id,
        date: date.date(),
      ),
    );
  }

  /// All more option buttons.
  List<PopupMenuItem<int>> _menuOptions() {
    return <PopupMenuItem<int>>[
      PopupMenuItem<int>(
        value: 0,
        child: Text(markSkip),
      ),
      PopupMenuItem<int>(
        value: 1,
        child: Text(markDone),
      ),
      PopupMenuItem<int>(
        value: 2,
        child: Text(updateReason),
      ),
    ];
  }

  /// Creates all failures.
  List<Widget> _children(BuildContext context) {
    final List<Widget> output = <Widget>[];
    for (final String id in _day.failures.keys) {
      output.add(const SizedBox(height: 8.0));
      output.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Text(
                _idToName[id],
                style: Theme.of(context).textTheme.subtitle1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              child: Text(
                _day.failures[id],
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            if (!_bloc.isEnded())
              PopupMenuButton<dynamic>(
                elevation: 8,
                onSelected: (dynamic value) {
                  if (value == 0) {
                    _bloc.mark(id, Status.skipped);
                  } else if (value == 1) {
                    _bloc.mark(id, Status.done);
                  } else if (value == 2) {
                    _showFailureReasonSheet(context, id, _day.date);
                  }
                },
                itemBuilder: (_) {
                  return _menuOptions();
                },
                child: const Icon(moreIcon),
              ),
          ],
        ),
      );
    }
    return output;
  }

  @override
  Widget build(BuildContext context) {
    final DateTime date = _day.date.date();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Text(
            '${weekdays[date.weekday - 1]} ${date.day} ${months[date.month - 1]}',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          const SizedBox(height: 8.0),
          Column(
            children: _children(context),
          )
        ],
      ),
    );
  }
}

/// A expansion tile to show all failures.
class FailuresPanel extends StatelessWidget {
  /// Constructs.
  const FailuresPanel(
    this._days,
    this._idToName,
    this._bloc, {
    Key key,
  }) : super(key: key);

  final Map<String, String> _idToName;
  final List<Day> _days;
  final CurrentBloc _bloc;

  /// Returns widgets for expansion tile.
  List<Widget> _children() {
    final List<Widget> output = <Widget>[];
    for (final Day day in _days) {
      if (day.failures.isNotEmpty) {
        output.add(_DaysFailures(day, _idToName, _bloc));
        output.add(const Divider());
      }
    }
    return output;
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(failures),
      children: _children(),
    );
  }
}
