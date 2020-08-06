import 'package:flutter/material.dart';

import 'package:habitflow/blocs/current_cycle_bloc.dart';
import 'package:habitflow/blocs/cycles_bloc.dart';
import 'package:habitflow/components/cycle_card.dart';
import 'package:habitflow/models/cycle.dart';
import 'package:habitflow/resources/behaviour.dart';

/// Cycles screen
class Cycles extends StatelessWidget {
  /// Constructs
  const Cycles(
    this._cyclesBloc,
    this._currentBloc, {
    Key key,
  }) : super(key: key);

  final CyclesBloc _cyclesBloc;
  final CurrentCycleBloc _currentBloc;

  /// Returns cards for previous cycles.
  List<Widget> _cycles() {
    final List<Widget> output = <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: CycleCard(cycle: _currentBloc.current),
      ),
    ];
    _cyclesBloc.cycles.forEach((String key, Cycle value) {
      output.add(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CycleCard(cycle: value),
        ),
      );
    });
    return output;
  }

  @override
  Widget build(BuildContext context) {
    if (_currentBloc.current == null || _cyclesBloc.cycles == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return SafeArea(
      child: SingleChildScrollView(
        physics: scrollPhysics,
        child: Column(
          children: _cycles(),
        ),
      ),
    );
  }
}
