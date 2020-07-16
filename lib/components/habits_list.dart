import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

import 'package:habitflow/components/neu_card.dart';
import 'package:habitflow/components/reward_points.dart';
import 'package:habitflow/models/habit.dart';

Color _colorFromHex(String hexColor) {
  final String hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));
}

/// A widget to show a single habit.
class _Habit extends StatelessWidget {
  /// Constructs
  const _Habit(this._habit, {Key key}) : super(key: key);

  final Habit _habit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: NeuCard(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            child: Ink(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        mapToIconData(_habit.iconData),
                        color: _colorFromHex(_habit.colorHex),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Text(
                          _habit.name,
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      RewardPoints(
                        _habit.points,
                        size: 24.0,
                        color: _colorFromHex(_habit.colorHex),
                      ),
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
  const HabitsList(this._habits, {Key key}) : super(key: key);

  final List<Habit> _habits;

  @override
  Widget build(BuildContext context) {
    if (_habits == null) {
      return const LinearProgressIndicator();
    }
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 24.0),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: ListView.separated(
                    itemCount: _habits.length,
                    separatorBuilder: (BuildContext ctxt, int index) =>
                        const SizedBox(height: 8.0),
                    itemBuilder: (BuildContext ctxt, int index) {
                      return _Habit(_habits[index]);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
