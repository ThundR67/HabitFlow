import 'package:flutter/material.dart';
import 'package:habitflow/components/cycle.dart';

/// Cycles screen
class Cycles extends StatelessWidget {
  /// Constructs
  const Cycles({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            CycleCard(),
          ],
        ),
      ),
    );
  }
}
