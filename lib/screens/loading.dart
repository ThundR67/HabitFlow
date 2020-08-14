import 'package:flutter/material.dart';
import 'package:habitflow/blocs/current_bloc.dart';
import 'package:habitflow/blocs/intro_bloc.dart';
import 'package:habitflow/resources/routes.dart';
import 'package:habitflow/resources/widgets.dart';
import 'package:provider/provider.dart';

/// Shows indicator and does all the loading.
class Loading extends StatelessWidget {
  /// Constructs.
  const Loading();

  @override
  Widget build(BuildContext context) {
    final CurrentBloc bloc = Provider.of<CurrentBloc>(context);
    final IntroBloc introBloc = Provider.of<IntroBloc>(context);

    if (introBloc.intros != null) {
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
