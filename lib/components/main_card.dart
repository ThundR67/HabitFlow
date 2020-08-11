import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:habitflow/components/tappable_neu_card.dart';

/// A slidable, tappable and showcasable card.
class MainCard extends StatelessWidget {
  /// Constructs.
  const MainCard({
    @required this.child,
    @required this.actions,
    @required this.secondaryActions,
    @required this.onTap,
    @required this.controller,
    this.introShown = false,
  });

  /// Child of the card.
  final Widget child;

  /// Primary actions of the card.
  final List<Widget> actions;

  /// Secondary actions of the card.
  final List<Widget> secondaryActions;

  /// Funtion to run on tap.
  final Function() onTap;

  /// Should intro be shown.
  final bool introShown;

  /// Controller for slidable.
  final SlidableController controller;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actions: actions,
      secondaryActions: secondaryActions,
      actionPane: const SlidableDrawerActionPane(),
      controller: controller,
      child: Builder(
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 16.0,
            ),
            child: TappableCard(
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: child,
              ),
            ),
          );
        },
      ),
    );
  }
}
