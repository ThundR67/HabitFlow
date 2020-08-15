import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:habitflow/blocs/current_bloc.dart';
import 'package:habitflow/blocs/cycles_bloc.dart';
import 'package:habitflow/blocs/intro_bloc.dart';
import 'package:habitflow/components/cycle_card.dart';
import 'package:habitflow/models/cycle.dart';
import 'package:habitflow/resources/behaviour.dart';
import 'package:habitflow/resources/strings.dart' as strings;
import 'package:habitflow/resources/widgets.dart';

/// A screen to show current and previous cycles.
class Cycles extends StatelessWidget {
  /// Constructs
  Cycles();

  final GlobalKey _key = GlobalKey();

  /// Returns cards for previous cycles.
  List<Widget> _cycles(CurrentBloc currentBloc, CyclesBloc cyclesBloc) {
    return [for (Cycle cycle in cyclesBloc.cycles) CycleCard(cycle: cycle)];
  }

  @override
  Widget build(BuildContext context) {
    final CurrentBloc currentBloc = Provider.of<CurrentBloc>(context);
    final CyclesBloc cyclesBloc = Provider.of<CyclesBloc>(context);
    final IntroBloc introBloc = Provider.of<IntroBloc>(context);

    if (currentBloc.current == null ||
        cyclesBloc.cycles == null ||
        introBloc.intros == null) {
      return circularIndicator;
    }

    final List<Cycle> cycles = [currentBloc.current] + cyclesBloc.cycles;

    return SafeArea(
      child: ListView.builder(
        physics: scrollPhysics,
        itemCount: cycles.length,
        itemBuilder: (context, index) => CycleCard(cycle: cycles[index]),
      ),
    );
  }
}
