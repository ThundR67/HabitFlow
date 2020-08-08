import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

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
              RaisedButton(onPressed: () {
                ThemeProvider.controllerOf(context).nextTheme();
              }),
            ],
          ),
        ),
      ),
    );
  }
}
