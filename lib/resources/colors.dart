import 'package:flutter/material.dart';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:tinycolor/tinycolor.dart';

/// Returns neumorphic style for neumorphic elements.
NeumorphicStyle neuStyle(
  BuildContext context, {
  double radius = 8,
  double depth = 4,
}) {
  final bool isLight = Theme.of(context).brightness == Brightness.light;
  final Color color = Theme.of(context).scaffoldBackgroundColor;
  final Color dark = TinyColor(color).darken(isLight ? 20 : 3).color;
  final Color light = TinyColor(color).lighten(isLight ? 24 : 6).color;

  return NeumorphicStyle(
    boxShape: NeumorphicBoxShape.roundRect(
      BorderRadius.circular(radius),
    ),
    depth: depth,
    lightSource: LightSource.topLeft,
    intensity: 1,
    color: color,
    shadowDarkColor: dark,
    shadowLightColor: light,
    shadowDarkColorEmboss: dark,
    shadowLightColorEmboss: light,
  );
}
