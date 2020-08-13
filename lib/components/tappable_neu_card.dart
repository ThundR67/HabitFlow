import 'package:flutter/material.dart';

import 'package:habitflow/components/neu_card.dart';

/// A widget to show tappable neu card.
class TappableCard extends StatelessWidget {
  /// Constructs.
  const TappableCard({
    @required this.child,
    @required this.onTap,
    this.radius = 8.0,
  });

  /// Child of card.
  final Widget child;

  /// Function to run on tap.
  final Function() onTap;

  /// Radius of card.
  final double radius;

  @override
  Widget build(BuildContext context) {
    return NeuCard(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Ink(
            child: child,
          ),
        ),
      ),
    );
  }
}
