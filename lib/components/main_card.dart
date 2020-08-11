import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:habitflow/components/tappable_neu_card.dart';
import 'package:showcaseview/showcase.dart';
import 'package:showcaseview/showcaseview.dart';

/// A slidable, tappable and showcasable card.
class MainCard extends StatefulWidget {
  /// Constructs.
  const MainCard({
    @required this.child,
    @required this.actions,
    @required this.secondaryActions,
    @required this.onTap,
    @required this.controller,
    @required this.description,
    this.isIntroToBeShown = false,
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
  final bool isIntroToBeShown;

  /// Description for the intro.
  final String description;

  /// Controller for slidable.
  final SlidableController controller;

  @override
  _MainCardState createState() => _MainCardState();
}

class _MainCardState extends State<MainCard> {
  final GlobalKey _key = GlobalKey();
  bool _introShown = false;

  /// Shows an intro.
  void _showIntro(BuildContext context) {
    if (!_introShown) {
      const Duration duration = Duration(seconds: 3);
      final SlidableState state = Slidable.of(context);
      ShowCaseWidget.of(context).startShowCase([_key]);
      state.open();
      Future.delayed(duration).whenComplete(() {
        state.open(actionType: SlideActionType.secondary);
        Future.delayed(duration).whenComplete(state.close);
      });
    }
    setState(() => _introShown = true);
  }

  @override
  Widget build(BuildContext context) {
    return Showcase(
      key: _key,
      description: widget.description,
      child: Slidable(
        actions: widget.actions,
        secondaryActions: widget.secondaryActions,
        actionPane: const SlidableDrawerActionPane(),
        controller: widget.controller,
        child: Builder(
          builder: (context) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (widget.isIntroToBeShown) _showIntro(context);
            });
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 16.0,
              ),
              child: TappableCard(
                onTap: widget.onTap,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  child: widget.child,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
