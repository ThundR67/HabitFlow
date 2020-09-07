import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

/// A slidable card.
class SlidableCard extends StatelessWidget {
  /// Constructs.
  const SlidableCard({
    @required this.child,
    @required this.actions,
    @required this.secondaryActions,
    @required this.controller,
  });

  /// Child of the card.
  final Widget child;

  /// Primary actions of the card.
  final List<Widget> actions;

  /// Secondary actions of the card.
  final List<Widget> secondaryActions;

  /// Controller for slidable.
  final SlidableController controller;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: const SlidableDrawerActionPane(),
      actions: actions,
      secondaryActions: secondaryActions,
      controller: controller,
      child: Card(child: child),
    );
  }
}
