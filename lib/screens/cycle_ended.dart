import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:habitflow/blocs/current_bloc.dart';
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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.play();
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
                  numberOfParticles: 20,
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
