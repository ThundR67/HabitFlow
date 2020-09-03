import 'package:flutter/material.dart';

import 'package:habitflow/helpers/statistics.dart';
import 'package:habitflow/resources/strings.dart';

/// Widget to show successes, skips, failures.
class Stats extends StatelessWidget {
  /// Constructs.
  const Stats(this.statistics);

  /// Statistics to display.
  final Statistics statistics;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _Stat(
          text: successes,
          number: statistics.amountDone,
        ),
        _Stat(
          text: skips,
          number: statistics.amountSkipped,
        ),
        _Stat(
          text: failures,
          number: statistics.amountFailed,
        )
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({
    @required this.text,
    @required this.number,
  });

  final String text;
  final int number;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96,
      width: 96,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              text,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Text(
              number.toString(),
              style: Theme.of(context).textTheme.headline5,
            ),
          ],
        ),
      ),
    );
  }
}
