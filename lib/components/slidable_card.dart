import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

/// A slidable card.
class SlidableCard extends StatefulWidget {
  /// Constructs.
  const SlidableCard({
    @required this.child,
    @required this.actions,
    @required this.secondaryActions,
    @required this.controller,
    this.shouldShowIntro = false,
  });

  /// Child of the card.
  final Widget child;

  /// Primary actions of the card.
  final List<Widget> actions;

  /// Secondary actions of the card.
  final List<Widget> secondaryActions;

  /// Controller for slidable.
  final SlidableController controller;

  /// Name of intro.
  final bool shouldShowIntro;

  @override
  _SlidableCardState createState() => _SlidableCardState();
}

class _SlidableCardState extends State<SlidableCard> {
  bool _showed = false;

  Future _showIntro(SlidableState slidable) async {
    if (widget.shouldShowIntro && !_showed) {
      const Duration dur = Duration(seconds: 2);
      await Future.delayed(const Duration(milliseconds: 700));
      slidable.open(actionType: SlideActionType.primary);
      await Future.delayed(dur);
      slidable.close();
      slidable.open(actionType: SlideActionType.secondary);
      await Future.delayed(dur);
      slidable.close();
      _showed = true;
    }
  }

  @override
  Widget build(BuildContext _) {
    return Slidable(
      actionPane: const SlidableDrawerActionPane(),
      actions: widget.actions,
      secondaryActions: widget.secondaryActions,
      controller: widget.controller,
      child: Card(
        child: Builder(
          builder: (context) {
            _showIntro(Slidable.of(context));
            return widget.child;
          },
        ),
      ),
    );
  }
}
