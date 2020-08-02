import 'package:flutter/material.dart';

import 'package:habitflow/blocs/current_cycle_bloc.dart';
import 'package:habitflow/models/dates.dart';
import 'package:habitflow/models/day.dart';
import 'package:habitflow/resources/icons.dart';
import 'package:habitflow/resources/strings.dart';

/*
for (final String id in day.failures.keys) {
        toAdd.add(
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(day.date),
                    Text(
                      _idToName[id],
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Expanded(child: Text(day.failures[id])),
                if (parseDate(_bloc.current.end).isAfter(DateTime.now()))
                  PopupMenuButton<dynamic>(
                    elevation: 8,
                    onSelected: (dynamic value) {
                      _bloc.skip(id, parseDate(day.date));
                    },
                    child: const Icon(moreIcon),
                    itemBuilder: (_) {
                      return <PopupMenuItem<int>>[
                        PopupMenuItem<int>(
                          child: Text(markSkip),
                          value: 0,
                        ),
                      ];
                    },
                  ),
              ],
            ),
          ),
        );*/

/// A widget to show all failures of a day.
class _DaysFailures extends StatelessWidget {
  const _DaysFailures(
    this._day,
    this._idToName,
    this._bloc, {
    Key key,
  }) : super(key: key);

  final Day _day;
  final Map<String, String> _idToName;
  final CurrentCycleBloc _bloc;

  /// All more option buttons.
  List<PopupMenuItem<int>> _menuOptions() {
    return <PopupMenuItem<int>>[
      PopupMenuItem<int>(
        child: Text(markSkip),
        value: 0,
      ),
      PopupMenuItem<int>(
        child: Text(markDone),
        value: 0,
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
          children: <Widget>[
            Text(
              _idToName[id],
              style: Theme.of(context).textTheme.subtitle1,
            ),
            const Spacer(),
            Expanded(
              child: Text(
                _day.failures[id],
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            if (parseDate(_bloc.current.end).isAfter(DateTime.now()))
              PopupMenuButton<dynamic>(
                elevation: 8,
                onSelected: (dynamic value) {
                  if (value == 0) {
                    _bloc.skip(id, parseDate(_day.date));
                  } else if (value == 1) {
                    _bloc.done(id, parseDate(_day.date));
                  }
                  _day.failures.remove(id);
                },
                child: const Icon(moreIcon),
                itemBuilder: (_) {
                  return _menuOptions();
                },
              ),
          ],
        ),
      );
    }
    return output;
  }

  @override
  Widget build(BuildContext context) {
    final DateTime date = parseDate(_day.date);
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
  final CurrentCycleBloc _bloc;

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
