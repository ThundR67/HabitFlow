import 'package:flutter/material.dart';

import 'package:habitflow/services/quotes/quotes.dart';

/// A widget which shows random quote.
class Quote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      alignment: Alignment.center,
      child: Text(
        quotes[0],
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
