import 'package:flutter/material.dart';
import 'package:habitflow/resources/strings.dart';

/// FAQ page.
class FAQ extends StatelessWidget {
  /// Constructs.
  const FAQ();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          faqPage,
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      body: const Placeholder(),
    );
  }
}
