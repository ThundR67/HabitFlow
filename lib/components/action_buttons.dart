import 'package:flutter/material.dart';
import 'package:habitflow/blocs/current_bloc.dart';
import 'package:habitflow/blocs/points_bloc.dart';
import 'package:habitflow/blocs/rewards_bloc.dart';
import 'package:habitflow/components/action_button.dart';
import 'package:habitflow/components/failure_reason_sheet.dart';
import 'package:habitflow/helpers/sounds.dart';
import 'package:habitflow/models/habit.dart';
import 'package:habitflow/models/reward.dart';
import 'package:habitflow/models/status.dart';
import 'package:habitflow/resources/icons.dart';
import 'package:habitflow/resources/strings.dart';

/// Returns action button to undo marking [habit].
ActionButton undoAction(Habit habit, CurrentBloc bloc) {
  return ActionButton(
    color: Colors.orangeAccent[700],
    text: undo,
    onPressed: () => bloc.mark(habit.id, Status.unmarked),
    icon: undoIcon,
  );
}

/// Returns action button to mark [habit] as done.
ActionButton doneAction(Habit habit, PointsBloc pointsBloc, CurrentBloc bloc) {
  return ActionButton(
    color: Colors.green,
    text: done,
    onPressed: () {
      bloc.mark(habit.id, Status.done);
      pointsBloc.increment(habit.points);
      play('success');
    },
    icon: doneIcon,
  );
}

/// Returns action button to mark [habit] as skipped.
ActionButton skipAction(Habit habit, CurrentBloc bloc) {
  return ActionButton(
    color: Colors.blueAccent,
    text: skip,
    onPressed: () => bloc.mark(habit.id, Status.skipped),
    icon: skippedIcon,
  );
}

/// Returns action button to mark [habit] as failed.
ActionButton failAction(BuildContext context, Habit habit) {
  return ActionButton(
    color: Colors.redAccent,
    text: fail,
    onPressed: () => Scaffold.of(context).showBottomSheet<FailureReasonSheet>(
      (BuildContext context) => FailureReasonSheet(habit),
    ),
    icon: failedIcon,
  );
}

/// Returns action button take [reward].
ActionButton takeAction(
  BuildContext context,
  Reward reward,
  RewardsBloc bloc,
  PointsBloc pointsBloc,
) {
  return ActionButton(
    icon: takeIcon,
    text: take,
    color: Colors.blueAccent,
    onPressed: () {
      if (pointsBloc.points < reward.points) {
        Scaffold.of(context).showSnackBar(
          SnackBar(content: Text(notEnoughPoints)),
        );
        return;
      }
      bloc.take(reward);
      pointsBloc.decrement(reward.points);
    },
  );
}

/// Returns action button delete [reward].
ActionButton deleteAction(Reward reward, RewardsBloc bloc) {
  return ActionButton(
    icon: deleteIcon,
    text: delete,
    color: Colors.redAccent,
    onPressed: () => bloc.delete(reward),
  );
}
