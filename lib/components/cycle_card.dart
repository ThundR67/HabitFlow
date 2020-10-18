import 'package:flutter/material.dart';
import 'package:habitflow/blocs/intro_bloc.dart';

import 'package:habitflow/components/cycle_header.dart';
import 'package:habitflow/components/redirect.dart';
import 'package:habitflow/components/showable_widget.dart';

import 'package:habitflow/models/cycle.dart';
import 'package:habitflow/resources/routes.dart';
import 'package:habitflow/resources/strings.dart' as strings;
import 'package:habitflow/screens/cycle.dart';
import 'package:provider/provider.dart';

/// A card to show [cycle] data in Cycles page.
class CycleCard extends StatelessWidget {
  /// Constructs.
  const CycleCard({@required this.cycle});

  /// Cycle to show data of.
  final Cycle cycle;

  @override
  Widget build(BuildContext context) {
    final shouldShow = !Provider.of<IntroBloc>(context).intros[cycleIntro];

    return Showable(
      shouldShowcase: shouldShow,
      description: strings.cycleIntro,
      child: Card(
        child: InkWell(
          customBorder: Theme.of(context).cardTheme.shape,
          onTap: () => redirect(context, cycleInfoRoute, CycleInfo(cycle)),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: CycleHeader(cycle: cycle),
          ),
        ),
      ),
    );
  }
}
