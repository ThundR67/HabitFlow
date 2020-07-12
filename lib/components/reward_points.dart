import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

/// A widget to show current reward points held by user.
class RewardPoints extends StatelessWidget {
  /// Constructs
  const RewardPoints(this._points, {Key key}) : super(key: key);

  final int _points;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Neumorphic(
        child: const Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('hello'),
          ),
        ),
      ),
    );
  }
}
