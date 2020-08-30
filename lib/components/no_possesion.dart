import 'package:flutter/material.dart';

import 'package:habitflow/resources/icons.dart';

/// TODO: think about this time

/// Widget to indicate to user of lack of something.
///
/// Such as no habits, rewards, or active habits.
class NoPossesion extends StatelessWidget {
  /// Constructs.
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
            color: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle2.copyWith(
                    color: Colors.grey,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
