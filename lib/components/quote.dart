import 'dart:math';

import 'package:flutter/material.dart';

import 'package:habitflow/services/quotes/quotes.dart';

/// A widget which shows random quote.
class Quote extends StatelessWidget {
  /// Constructs.
  const Quote(this._quoteID);

  final int _quoteID;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 24.0, left: 8.0, right: 8.0),
      alignment: Alignment.center,
      child: Text(
        quotes[_quoteID],
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
