import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: NeuCard(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            child: Ink(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        mapToIconData(_reward.iconData),
                        color: _colorFromHex(_reward.colorHex),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              _reward.name,
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              'X ${_reward.amountTaken}',
                            ),
                          ],
                        ),
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
            ),
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
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: ListView.separated(
          itemCount: _rewards.length,
          separatorBuilder: (BuildContext ctxt, int index) =>
              const SizedBox(height: 8.0),
          itemBuilder: (BuildContext ctxt, int index) {
            return _Reward(_rewards[index]);
          },
        ),
      ),
    );
  }
}
