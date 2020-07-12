import 'package:flutter/material.dart';

/// A Neumorphic card.
class NeuCard extends StatelessWidget {
  /// Constructs
  const NeuCard({Key key, this.child, this.radius}) : super(key: key);

  /// Childrens of the card.
  final Widget child;

  /// Radius of the card.
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[900],
          boxShadow: const <BoxShadow>[
            BoxShadow(
              blurRadius: 18.0,
              color: Color(0xff141414),
              offset: Offset(8, 8),
            ),
            BoxShadow(
              blurRadius: 18.0,
              color: Color(0xff2e2e2e),
              offset: Offset(-8, -8),
            ),
          ],
          gradient: null,
          borderRadius: BorderRadius.all(Radius.circular(radius))),
      child: child,
    );
  }
}
