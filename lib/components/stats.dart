import 'package:flutter/material.dart';

import 'package:habitflow/components/neu_card.dart';
import 'package:habitflow/resources/strings.dart';

/// Widget to show successes, skips, failures.
class Stats extends StatelessWidget {
  /// Constructs.
  const Stats({
    this.successesNum = 0,
    this.skipsNum = 0,
    this.failuresNum = 0,
  });

  /// Number of successes.
  final int successesNum;

  /// Number of skips.
  final int skipsNum;

  /// Number of failures.
  final int failuresNum;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _Stat(
          text: successes,
          number: successesNum,
        ),
        _Stat(
          text: skips,
          number: skipsNum,
        ),
        _Stat(
          text: failures,
          number: failuresNum,
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
      child: NeuCard(
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
