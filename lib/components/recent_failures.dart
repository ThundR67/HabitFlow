import 'package:flutter/material.dart';

import 'package:habitflow/resources/strings.dart';

/// Shows [failures] as recent failures.
class RecentFailures extends StatelessWidget {
  /// Constructs.
  const RecentFailures(this._failures);

  final List<String> _failures;

  @override
  Widget build(BuildContext context) {
    _failures.remove(unprovidedReason);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            recentFailures,
            style: Theme.of(context).textTheme.headline5,
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: _failures.length,
            itemBuilder: (_, index) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(_failures[index]),
                  ),
                  const Divider(),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
