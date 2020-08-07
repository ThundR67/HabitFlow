import 'package:flutter/material.dart';
import 'package:habitflow/resources/icons.dart';

/// Widget to indicate something to user such as no habits, rewards, or active habits.
class NoPossesion extends StatelessWidget {
  const NoPossesion({
    @required this.text,
    this.icon = addIcon,
  });

  /// Icon to show.
  final IconData icon;

  /// Text to show.
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Icon(
            icon,
            size: 96,
          ),
          const SizedBox(height: 16.0),
          Text(text),
        ],
      ),
    );
  }
}
