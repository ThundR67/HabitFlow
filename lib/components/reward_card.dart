import 'package:flutter/material.dart';

import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:habitflow/components/action_buttons.dart';
import 'package:habitflow/components/main_card.dart';
import 'package:habitflow/components/reward_points.dart';
import 'package:habitflow/helpers/colors.dart';
import 'package:habitflow/models/reward.dart';

/// A widget to show a reward in a card.
class RewardCard extends StatelessWidget {
  /// Constructs.
  const RewardCard({this.reward, this.controller});

  /// Reward to show.
  final Reward reward;

  /// Slidable Controller.
  final SlidableController controller;

  @override
  Widget build(BuildContext context) {
    return SlidableCard(
      actions: [takeAction(context, reward)],
      secondaryActions: [deleteAction(context, reward)],
      controller: controller,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Icon(
            mapToIconData(reward.iconData),
            color: hexToColor(reward.colorHex),
            size: 24,
          ),
        ),
        title: Text(
          reward.name,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          'X ${reward.amountTaken}',
          style: Theme.of(context).textTheme.subtitle1,
        ),
        trailing: RewardPoints(
          points: reward.points,
          color: hexToColor(reward.colorHex),
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
    );
  }
}
