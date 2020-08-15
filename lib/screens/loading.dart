import 'package:flutter/material.dart';
import 'package:habitflow/blocs/current_bloc.dart';
import 'package:habitflow/blocs/cycles_bloc.dart';
import 'package:habitflow/blocs/habits_bloc.dart';
import 'package:habitflow/blocs/intro_bloc.dart';
import 'package:habitflow/blocs/points_bloc.dart';
import 'package:habitflow/blocs/rewards_bloc.dart';
import 'package:habitflow/blocs/theme_bloc.dart';
import 'package:habitflow/resources/routes.dart';
import 'package:habitflow/resources/widgets.dart';
import 'package:provider/provider.dart';

/// Shows indicator and does all the loading.
class Loading extends StatelessWidget {
  /// Constructs.
  const Loading();

  /// Checks if all blocs have been loaded.
  bool _isAllLoaded(BuildContext context) {
    final CurrentBloc currentBloc = Provider.of<CurrentBloc>(context);
    final IntroBloc introBloc = Provider.of<IntroBloc>(context);
    final HabitsBloc habitsBloc = Provider.of<HabitsBloc>(context);
    final CyclesBloc cyclesBloc = Provider.of<CyclesBloc>(context);
    final RewardsBloc rewardsBloc = Provider.of<RewardsBloc>(context);
    final PointsBloc pointsBloc = Provider.of<PointsBloc>(context);
    return (currentBloc.current != null) &&
        (introBloc.intros != null) &&
        (habitsBloc.habits != null) &&
        (cyclesBloc.cycles) != null &&
        (rewardsBloc.rewards != null) &&
        (pointsBloc.points != null);
  }

  @override
  Widget build(BuildContext context) {
    final CurrentBloc bloc = Provider.of<CurrentBloc>(context);
    final IntroBloc introBloc = Provider.of<IntroBloc>(context);

    if (_isAllLoaded(context)) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          if (!introBloc.intros[mainIntro]) {
            Navigator.pushReplacementNamed(context, introRoute);
          } else if (bloc.isEnded()) {
            Navigator.pushReplacementNamed(context, cycleEndedRoute);
          } else {
            Navigator.pushReplacementNamed(context, homeRoute);
          }
        },
      );
    }

    return const Scaffold(
      body: circularIndicator,
    );
  }
}
