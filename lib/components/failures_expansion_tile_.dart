import 'package:flutter/material.dart';
import 'package:habitflow/blocs/current_cycle_bloc.dart';
import 'package:habitflow/models/dates.dart';
import 'package:habitflow/models/day.dart';
import 'package:habitflow/resources/icons.dart';
import 'package:habitflow/resources/strings.dart';

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
      for (final String id in day.failures.keys) {
        output.add(
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
        );
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
