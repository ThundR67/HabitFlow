import 'package:flutter/material.dart';

import 'package:habitflow/blocs/current_bloc.dart';
import 'package:habitflow/blocs/cycles_bloc.dart';
import 'package:habitflow/components/cycle_card.dart';
import 'package:habitflow/models/cycle.dart';
import 'package:habitflow/resources/behaviour.dart';
import 'package:habitflow/resources/widgets.dart';
import 'package:provider/provider.dart';

/// A screen to show current and previous cycles.
class Cycles extends StatelessWidget {
  /// Constructs
  const Cycles();

  /// Returns cards for previous cycles.
  List<Widget> _cycles(CurrentBloc currentBloc, CyclesBloc cyclesBloc) {
    // Adding current cycle.
    final List<Widget> output = <Widget>[];

    // Adding previous cycles.
    cyclesBloc.cycles.forEach(
      (String key, Cycle value) {
        output.add(
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CycleCard(cycle: value),
          ),
        );
      },
    );

    return output;
  }

  @override
  Widget build(BuildContext context) {
    final CurrentBloc currentBloc = Provider.of<CurrentBloc>(context);
    final CyclesBloc cyclesBloc = Provider.of<CyclesBloc>(context);

    if (currentBloc.current == null || cyclesBloc.cycles == null) {
      return circularIndicator;
    }

    return SafeArea(
      child: SingleChildScrollView(
        physics: scrollPhysics,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CycleCard(cycle: currentBloc.current),
            ),
            ..._cycles(currentBloc, cyclesBloc),
          ],
        ),
      ),
    );
  }
}
