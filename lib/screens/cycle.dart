import 'package:flutter/material.dart';
import 'package:habitflow/models/cycle.dart';

/// Shows data about a cycle.
class CycleInfo extends StatelessWidget {
  /// Constructs.
  const CycleInfo(this._cycle, {Key key}) : super(key: key);

  final Cycle _cycle;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Under Dev'),
    );
  }
}
