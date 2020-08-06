import 'package:flutter/material.dart';

/// Converts [hexColor] which is hex code to Color.
Color hexToColor(String hexColor) {
  final String hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));
}
