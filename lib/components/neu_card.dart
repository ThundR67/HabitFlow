import 'package:flutter/material.dart';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:habitflow/resources/colors.dart';

/// A Neumorphic card.
class NeuCard extends StatelessWidget {
  /// Constructs
  const NeuCard({
    Key key,
    @required this.context,
    this.child,
    this.radius = 8.0,
    this.depth = 3,
  }) : super(key: key);

  /// Context.
  final BuildContext context;

  /// Childrens of the card.
  final Widget child;

  /// Radius of the card.
  final double radius;

  /// Depth of the card.
  final double depth;

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      child: child,
      style: neuStyle(
        context,
        depth: depth,
        radius: radius,
      ),
    );
  }
}
