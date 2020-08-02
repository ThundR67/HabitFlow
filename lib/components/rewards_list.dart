import 'package:flutter/material.dart';

import 'package:flutter_iconpicker/flutter_iconpicker.dart';

import 'package:habitflow/components/neu_card.dart';
import 'package:habitflow/components/reward_options_sheet.dart';
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

  /// Shows reward options sheet.
  void _showSheet(BuildContext context, Reward reward) {
    Scaffold.of(context).showBottomSheet<RewardOptionsSheet>(
        (BuildContext context) => RewardOptionsSheet(reward));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: NeuCard(
        context: context,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => _showSheet(context, _reward),
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
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              'X ${_reward.amountTaken}',
                              style: Theme.of(context).textTheme.subtitle1,
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

  /// Returns cards for all rewards.
  List<Widget> _rewardCards() {
    final List<Widget> output = <Widget>[];
    for (final Reward reward in _rewards) {
      output.add(_Reward(reward));
    }
    return output;
  }

  @override
  Widget build(BuildContext context) {
    if (_rewards == null) {
      return const LinearProgressIndicator();
    }
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Column(
        children: _rewardCards(),
      ),
    );
  }
}
