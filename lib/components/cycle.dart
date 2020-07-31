import 'package:flutter/material.dart';

import 'package:habitflow/components/cycle_status.dart';
import 'package:habitflow/components/neu_card.dart';
import 'package:habitflow/models/cycle.dart';
import 'package:habitflow/screens/cycle.dart';

/// A card to show cycle data.
class CycleCard extends StatelessWidget {
  /// Constructs
  const CycleCard(this._cycle, {Key key}) : super(key: key);

  final Cycle _cycle;

  @override
  Widget build(BuildContext context) {
    return NeuCard(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Navigator.push<CycleInfo>(
            context,
            MaterialPageRoute<CycleInfo>(
              builder: (BuildContext context) => CycleInfo(_cycle),
            ),
          ),
          child: Ink(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: CycleStatus(_cycle),
            ),
          ),
        ),
      ),
    );
  }
}
