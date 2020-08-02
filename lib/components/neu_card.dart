import 'package:flutter/material.dart';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';

Color _darker(Color color, BuildContext context) {
  final int delta = Theme.of(context).brightness == Brightness.light ? 24 : 12;
  return Color.fromARGB(
    color.alpha,
    color.red - delta,
    color.green - delta,
    color.blue - delta,
  );
}

Color _lighter(Color color) {
  const int delta = 16;
  return Color.fromARGB(
    color.alpha,
    color.red + delta,
    color.green + delta,
    color.blue + delta,
  );
}

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
    final Color color = Theme.of(context).scaffoldBackgroundColor;
    return Neumorphic(
      child: child,
      style: NeumorphicStyle(
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(radius),
        ),
        depth: depth,
        intensity: Theme.of(context).brightness == Brightness.light ? 1.7 : 0.8,
        color: color,
        shadowDarkColor: _darker(color, context),
        shadowLightColor: _lighter(color), //customize color here
      ),
    );
  }
}
