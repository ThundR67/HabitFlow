import 'package:flutter/material.dart';

import 'package:habitflow/components/neu_card.dart';
import 'package:habitflow/components/reward_points.dart';
import 'package:habitflow/models/reward.dart';

Color _colorFromHex(String hexColor) {
  final String hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));
}

/// A widget to show a single reward.
class _Reward extends StatelessWidget {
  /// Constructs
  const _Reward(this._reward, {Key key}) : super(key: key);

  final Reward _reward;

  @override
  Widget build(BuildContext context) {
    return NeuCard(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.ac_unit,
                color: _colorFromHex(_reward.colorHex),
              ),
              const SizedBox(width: 8.0),
              Text(
                '${_reward.name} X${_reward.amountTaken}',
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.done),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {},
              ),
              RewardPoints(
                _reward.points,
                size: 24.0,
                color: _colorFromHex(_reward.colorHex),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A widget to show all rewards in list.
class RewardsList extends StatelessWidget {
  /// Constructs
  const RewardsList(this._rewards, {Key key}) : super(key: key);

  final List<Reward> _rewards;

  @override
  Widget build(BuildContext context) {
    if (_rewards == null) {
      return const LinearProgressIndicator();
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          _Reward(_rewards[0]),
        ],
      ),
    );
  }
}
