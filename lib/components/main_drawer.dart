import 'package:flutter/material.dart';
import 'package:habitflow/components/theme_dropdown.dart';
import 'package:habitflow/resources/strings.dart';

/// Main app drawer.
class MainDrawer extends StatelessWidget {
  /// Constructs.
  const MainDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(theme),
                  const ThemeDropDown(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
