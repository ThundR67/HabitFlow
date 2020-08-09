import 'package:flutter/material.dart';
import 'package:habitflow/components/theme_dropdown.dart';
import 'package:habitflow/resources/icons.dart';
import 'package:habitflow/resources/routes.dart';
import 'package:habitflow/resources/strings.dart';
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(theme),
                  const ThemeDropDown(),
                ],
              ),
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
                onPressed: () => launch(
                  'https://thundrx.pythonanywhere.com/faq',
                ),
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
            ],
          ),
        ),
      ),
    );
  }
}
