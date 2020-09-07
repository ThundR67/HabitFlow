import 'package:flutter/material.dart';

/// Shows history of successes, skips, or failures with reason.
class HistoryExpansionTile extends StatelessWidget {
  /// Constructs.
  const HistoryExpansionTile();

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text('Test'),
      childrenPadding: const EdgeInsets.all(16.0),
      children: [
        ListTile(
          leading: Icon(Icons.threesixty),
          title: Text('hey'),
          subtitle: Text('subtitle'),
        )
      ],
    );
  }
}
