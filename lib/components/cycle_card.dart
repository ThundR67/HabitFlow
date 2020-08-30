import 'package:flutter/material.dart';
import 'package:habitflow/blocs/ad_bloc.dart';

import 'package:habitflow/components/cycle_header.dart';
import 'package:habitflow/components/neu_card.dart';
import 'package:habitflow/components/redirect.dart';

import 'package:habitflow/models/cycle.dart';
import 'package:habitflow/resources/routes.dart';
import 'package:habitflow/screens/cycle.dart';
import 'package:provider/provider.dart';

/// A card to show [cycle] data in Cycles page.
class CycleCard extends StatelessWidget {
  /// Constructs.
  const CycleCard({@required this.cycle});

  /// Cycle to show data of.
  final Cycle cycle;

  /// Redirects to [CycleInfo] page.
  void _openCycleInfo(BuildContext context) {
    Provider.of<AdBloc>(context, listen: false).interstitial();
    redirect(context, cycleInfoRoute, CycleInfo(cycle));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 16.0,
      ),
      child: NeuCard(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => _openCycleInfo(context),
            child: Ink(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: CycleHeader(cycle: cycle),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
