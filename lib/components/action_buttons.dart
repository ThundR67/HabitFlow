import 'package:flutter/material.dart';
import 'package:habitflow/blocs/ad_bloc.dart';

import 'package:habitflow/blocs/current_bloc.dart';
import 'package:habitflow/blocs/points_bloc.dart';
import 'package:habitflow/blocs/rewards_bloc.dart';
import 'package:habitflow/components/action_button.dart';
import 'package:habitflow/components/failure_reason_sheet.dart';
import 'package:habitflow/helpers/scaffold.dart';
import 'package:habitflow/helpers/sounds.dart';
import 'package:habitflow/models/habit.dart';
import 'package:habitflow/models/reward.dart';
import 'package:habitflow/models/status.dart';
import 'package:habitflow/resources/icons.dart';
import 'package:habitflow/resources/strings.dart';
import 'package:provider/provider.dart';

/// Returns action button to undo marking [habit].
ActionButton undoAction(BuildContext context, Habit habit) {
  final CurrentBloc bloc = Provider.of<CurrentBloc>(context, listen: false);
  return ActionButton(
    color: Colors.orangeAccent[700],
    text: undo,
    onPressed: () {
      play('undo');
      bloc.mark(habit.id, Status.unmarked);
      Provider.of<AdBloc>(context, listen: false).interstitial();
    },
    icon: undoIcon,
  );
}

/// Returns action button to mark [habit] as done.
ActionButton doneAction(BuildContext context, Habit habit) {
  final CurrentBloc bloc = Provider.of<CurrentBloc>(context, listen: false);
  final PointsBloc pointsBloc = Provider.of<PointsBloc>(context);
  return ActionButton(
    color: Colors.green,
    text: done,
    onPressed: () {
      play('success');
      bloc.mark(habit.id, Status.done);
      pointsBloc.changeBy(habit.points);
      Provider.of<AdBloc>(context, listen: false).interstitial();
    },
    icon: doneIcon,
  );
}

/// Returns action button to mark [habit] as skipped.
ActionButton skipAction(BuildContext context, Habit habit) {
  final CurrentBloc bloc = Provider.of<CurrentBloc>(context, listen: false);
  return ActionButton(
    color: Colors.blueAccent,
    text: skip,
    onPressed: () {
      play('skip');
      bloc.mark(habit.id, Status.skipped);
      Provider.of<AdBloc>(context, listen: false).interstitial();
    },
    icon: skippedIcon,
  );
}

/// Returns action button to mark [habit] as failed.
ActionButton failAction(BuildContext context, Habit habit) {
  return ActionButton(
    color: Colors.redAccent,
    text: fail,
    onPressed: () => bottomsheet(context, FailureReasonSheet(id: habit.id)),
    icon: failedIcon,
  );
}

/// Returns action button take [reward].
ActionButton takeAction(BuildContext context, Reward reward) {
  final PointsBloc pointsBloc = Provider.of<PointsBloc>(context);
  final RewardsBloc bloc = Provider.of<RewardsBloc>(context);
  return ActionButton(
    icon: takeIcon,
    text: take,
    color: Colors.blueAccent,
    onPressed: () {
      if (pointsBloc.points < reward.points) {
        snackbar(context, notEnoughPoints);
        return;
      }
      play('success');
      bloc.take(reward);
      pointsBloc.changeBy(-reward.points);
      Provider.of<AdBloc>(context, listen: false).interstitial();
    },
  );
}

/// Returns action button delete [reward].
ActionButton deleteAction(BuildContext context, Reward reward) {
  return ActionButton(
    icon: deleteIcon,
    text: delete,
    color: Colors.redAccent,
    onPressed: () {
      Provider.of<RewardsBloc>(context, listen: false).delete(reward);
      Provider.of<AdBloc>(context, listen: false).interstitial();
    },
  );
}
