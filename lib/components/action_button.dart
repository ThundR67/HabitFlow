import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

/// Action button shown when with slidable.
class ActionButton extends StatelessWidget {
  /// Constructs
  const ActionButton({
    this.icon,
    this.text,
    this.color,
    this.onPressed,
  });

  /// Text to show.
  final String text;

  /// Icon of button.
  final IconData icon;

  /// Color of button.
  final Color color;

  /// Function to run.
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: IconSlideAction(
        caption: text,
        color: color,
        icon: icon,
        onTap: onPressed,
      ),
    );
  }
}
