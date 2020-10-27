import 'package:flutter/material.dart';

import 'package:habitflow/resources/strings.dart';

/// Shows list of [failures].
class FailureList extends StatelessWidget {
  /// Constructs.
  const FailureList({@required this.failures});

  /// List of failures to display.
  final List<String> failures;

  @override
  Widget build(BuildContext context) {
    failures.remove(unprovidedReason);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            recentFailures,
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            itemCount: failures.length,
            itemBuilder: (_, index) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(failures[index]),
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
