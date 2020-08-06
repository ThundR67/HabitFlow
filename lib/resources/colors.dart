import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

/// Returns neumorphic style for neumorphic elements.
NeumorphicStyle neuStyle(
  BuildContext context, {
  double radius = 8,
  double depth = 4,
}) {
  final bool isLight = Theme.of(context).brightness == Brightness.light;
  return NeumorphicStyle(
    boxShape: NeumorphicBoxShape.roundRect(
      BorderRadius.circular(radius),
    ),
    depth: depth,
    shape: NeumorphicShape.flat,
    lightSource: LightSource.topLeft,
    intensity: 1,
    color: Theme.of(context).scaffoldBackgroundColor,
    shadowDarkColor: Colors.black.withOpacity(0.4),
    shadowLightColor: Colors.white.withOpacity(isLight ? 1 : 0.22),
  );
}
