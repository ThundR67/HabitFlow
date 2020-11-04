import 'package:flutter/material.dart';

import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import 'package:habitflow/blocs/intro_bloc.dart';
import 'package:habitflow/components/action_buttons.dart';
import 'package:habitflow/components/reward_points.dart';
import 'package:habitflow/components/showable_widget.dart';
import 'package:habitflow/components/slidable_card.dart';
import 'package:habitflow/helpers/colors.dart';
import 'package:habitflow/models/reward.dart';
import 'package:habitflow/resources/strings.dart';

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
    final bloc = Provider.of<IntroBloc>(context);
    final shouldShow = !bloc.intros[rewardIntro];

    return Showable(
      onComplete: () => bloc.shown(rewardIntro),
      shouldShowcase: shouldShow,
      description: rewardSwipeDescription,
      child: SlidableCard(
        shouldShowIntro: shouldShow,
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
      ),
    );
  }
}
