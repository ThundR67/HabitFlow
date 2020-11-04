import 'package:flutter/material.dart';

import 'package:sup/sup.dart';

import 'package:habitflow/resources/icons.dart';

/// Custom implementation of QuickSup from sup package.
class QuickSup extends StatelessWidget {
  /// Constructs
  const QuickSup({this.icon, this.title, this.subtitle});

  /// Icon to show.
  final IconData icon;

  /// Title to show.
  final String title;

  /// Subtitle to show.
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Sup(
      image: Icon(
        icon ?? emptyStateIcon,
        size: 56.0,
      ),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }
}
