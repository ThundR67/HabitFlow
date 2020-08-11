import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:habitflow/blocs/intro_bloc.dart';
import 'package:habitflow/components/tappable_neu_card.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcase.dart';
import 'package:showcaseview/showcaseview.dart';

/// A slidable, tappable and showcasable card.
class MainCard extends StatelessWidget {
  /// Constructs.
  MainCard({
    @required this.child,
    @required this.actions,
    @required this.secondaryActions,
    @required this.onTap,
    @required this.controller,
    @required this.description,
    @required this.intro,
  });

  /// Child of the card.
  final Widget child;

  /// Primary actions of the card.
  final List<Widget> actions;

  /// Secondary actions of the card.
  final List<Widget> secondaryActions;

  /// Funtion to run on tap.
  final Function() onTap;

  /// Name of intro.
  final String intro;

  /// Description for the intro.
  final String description;

  /// Controller for slidable.
  final SlidableController controller;

  final GlobalKey _key = GlobalKey();

  /// Shows an intro and marks it as shown.
  void _showIntro(BuildContext context, IntroBloc bloc) {
    if (bloc.introsBeingShown[intro]) return;
    bloc.beingShown(intro);

    print('called');
    const Duration duration = Duration(seconds: 3);
    final SlidableState state = Slidable.of(context);

    ShowCaseWidget.of(context).startShowCase([_key]);
    state.open();
    Future.delayed(duration).whenComplete(() {
      state.close();
      state.open(actionType: SlideActionType.secondary);
      Future.delayed(duration).whenComplete(() {
        state.close();
      });
    });

    bloc.shown(intro);
  }

  @override
  Widget build(BuildContext context) {
    final IntroBloc bloc = Provider.of<IntroBloc>(context);
    return Showcase(
      key: _key,
      description: description,
      child: Slidable(
        actions: actions,
        secondaryActions: secondaryActions,
        actionPane: const SlidableDrawerActionPane(),
        controller: controller,
        child: Builder(
          builder: (context) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (bloc.intros != null) {
                if (!bloc.intros[intro]) {
                  _showIntro(context, bloc);
                }
              }
            });
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
      ),
    );
  }
}
