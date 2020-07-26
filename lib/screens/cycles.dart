import 'package:flutter/material.dart';
import 'package:habitflow/blocs/current_cycle_bloc.dart';
import 'package:habitflow/blocs/cycles_bloc.dart';
import 'package:habitflow/components/cycle.dart';
import 'package:habitflow/models/success_rate.dart';

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

  @override
  Widget build(BuildContext context) {
    if (_currentBloc.current == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            CycleCard(_currentBloc.current),
          ],
        ),
      ),
    );
  }
}
