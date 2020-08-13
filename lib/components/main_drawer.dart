import 'package:flutter/material.dart';
import 'package:habitflow/components/theme_dropdown.dart';
import 'package:habitflow/resources/icons.dart';
import 'package:habitflow/resources/routes.dart';

import 'package:habitflow/resources/strings.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

/// Main app drawer.
class MainDrawer extends StatelessWidget {
  /// Constructs.
  const MainDrawer();

  /// Shows about dialog.
  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationVersion: appVersion,
      applicationName: appName,
      applicationLegalese: appLegalese,
      applicationIcon: Image.asset(
        'assets/images/logo.png',
        fit: BoxFit.cover,
        height: 44,
      ),
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: Text(appDescription),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    theme,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  const SizedBox(width: 8.0),
                  const ThemeDropDown(),
                ],
              ),
              const Divider(),
              FlatButton(
                onPressed: () => _showAboutDialog(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(aboutIcon),
                    const SizedBox(width: 8.0),
                    Text(about),
                  ],
                ),
              ),
              FlatButton(
                onPressed: () => Navigator.of(context).pushNamed(faqRoute),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(faqIcon),
                    const SizedBox(width: 8.0),
                    Text(faqPage),
                  ],
                ),
              ),
              FlatButton(
                onPressed: () => Share.share(shareValue),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(shareIcon),
                    const SizedBox(width: 8.0),
                    Text(share),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
