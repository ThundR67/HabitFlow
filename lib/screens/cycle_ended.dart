import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:habitflow/blocs/current_bloc.dart';
import 'package:habitflow/blocs/points_bloc.dart';
import 'package:habitflow/blocs/rewards_bloc.dart';
import 'package:habitflow/helpers/sounds.dart';
import 'package:habitflow/resources/routes.dart';
import 'package:habitflow/resources/strings.dart';
import 'package:provider/provider.dart';

/// A screen to show when cycle ends
class CycleEnded extends StatefulWidget {
  /// Constructs.
  const CycleEnded();

  @override
  _CycleEndedState createState() => _CycleEndedState();
}

class _CycleEndedState extends State<CycleEnded> {
  ConfettiController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ConfettiController(duration: const Duration(seconds: 3));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final CurrentBloc bloc = Provider.of<CurrentBloc>(context);
    final RewardsBloc rewardsBloc = Provider.of<RewardsBloc>(context);
    final PointsBloc pointsBloc = Provider.of<PointsBloc>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.play();
      play('success');
    });

    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              Align(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      cycleEnded,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      cycleEndedDescription,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const SizedBox(height: 16.0),
                    RaisedButton(
                      color: Colors.white,
                      onPressed: () {
                        bloc.create();
                        pointsBloc.reset();
                        rewardsBloc.reset();
                        Navigator.of(context).pushReplacementNamed(homeRoute);
                      },
                      child: Text(
                        startCycle,
                        style: Theme.of(context).textTheme.button.copyWith(
                              color: Colors.blue,
                            ),
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ConfettiWidget(
                  confettiController: _controller,
                  blastDirectionality: BlastDirectionality.explosive,
                  blastDirection: 3.18 / 2,
                  numberOfParticles: 50,
                  maxBlastForce: 100,
                  minBlastForce: 80,
                  gravity: 0.1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
