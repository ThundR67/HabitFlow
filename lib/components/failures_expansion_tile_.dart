import 'package:flutter/material.dart';
import 'package:habitflow/models/day.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

/// A expansion tile to show all failures.
class FailuresPanel extends StatelessWidget {
  /// Constructs.
  const FailuresPanel(this._days, this._idToName, {Key key}) : super(key: key);

  final Map<String, String> _idToName;
  final List<Day> _days;

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
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: null,
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
      title: const Text('Failures'),
      children: _children(),
    );
  }
}
