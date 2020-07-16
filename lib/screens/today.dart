import 'package:flutter/material.dart';
import 'package:habitflow/components/quote.dart';

/// A screen to show user about todays information.
class Today extends StatelessWidget {
  /// Constructs.
  const Today(this._quoteID, {Key key}) : super(key: key);

  final int _quoteID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Quote(_quoteID),
        ],
      ),
    );
  }
}
