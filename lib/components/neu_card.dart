import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

/// A Neumorphic card.
class NeuCard extends StatelessWidget {
  /// Constructs
  const NeuCard({
    Key key,
    this.child,
    this.radius = 8.0,
    this.depth = 4,
  }) : super(key: key);

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
      style: NeumorphicStyle(
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(radius),
        ),
        depth: depth,
        intensity: 1,
        color: Colors.grey[850],
        shadowDarkColor: Colors.grey[900],
        shadowLightColor: Colors.grey[800], //customize color here
      ),
    );
  }
}
