import 'package:flutter/material.dart';

import 'package:flutter_iconpicker/flutter_iconpicker.dart';

import 'package:habitflow/components/habits_option_sheet.dart';
import 'package:habitflow/components/neu_card.dart';
import 'package:habitflow/components/reward_points.dart';
import 'package:habitflow/components/status_view.dart';
import 'package:habitflow/models/habit.dart';
import 'package:habitflow/models/status.dart';
import 'package:habitflow/resources/behaviour.dart';

Color _colorFromHex(String hexColor) {
  final String hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));
}

/// A widget to show a single habit.
class _Habit extends StatelessWidget {
  /// Constructs
  const _Habit(this._habit, this._status, {Key key}) : super(key: key);

  final Habit _habit;
  final Status _status;

  // Shows reward options sheet.
  void _showSheet(BuildContext context) {
    Scaffold.of(context).showBottomSheet<HabitsOptionSheet>(
      (BuildContext context) => HabitsOptionSheet(
        _habit,
        _status,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: NeuCard(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => _showSheet(context),
            child: Ink(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        mapToIconData(_habit.iconData),
                        color: _status == Status.unmarked
                            ? _colorFromHex(_habit.colorHex)
                            : Colors.grey,
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Text(
                          _habit.name,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            color: _status == Status.unmarked
                                ? Colors.white
                                : Colors.grey,
                            decoration: _status == Status.unmarked
                                ? null
                                : TextDecoration.lineThrough,
                          ),
                        ),
                      ),
                      if (_status == Status.unmarked)
                        RewardPoints(
                          _habit.points,
                          size: 24.0,
                          color: _colorFromHex(_habit.colorHex),
                        )
                      else
                        StatusView(_status)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// A widget to show all habits in list.
class HabitsList extends StatelessWidget {
  /// Constructs
  const HabitsList(this._habits, this._statuses, {Key key}) : super(key: key);

  final List<Habit> _habits;
  final List<Status> _statuses;

  /// Returns all habits.
  List<Widget> _habitsCards() {
    final List<Widget> output = <Widget>[];
    for (int i = 0; i < _habits.length; i++) {
      if (_habits[i].activeDays.contains(DateTime.now().weekday)) {
        Status status = Status.unmarked;
        if (_statuses.length > i) {
          status = _statuses[i];
        }
        output.add(const SizedBox(height: 8.0));
        output.add(_Habit(_habits[i], status));
      }
    }
    return output;
  }

  @override
  Widget build(BuildContext context) {
    if (_habits == null || _statuses == null) {
      return const LinearProgressIndicator();
    }
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Column(
        children: _habitsCards(),
      ),
    );
  }
}
