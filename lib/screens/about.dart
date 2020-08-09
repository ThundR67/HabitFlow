import 'package:flutter/material.dart';
import 'package:habitflow/resources/strings.dart';

/// About page.
class About extends StatelessWidget {
  /// Constructs.
  const About();

  /// Shows about dialog.
  void _showAboutDialog(BuildContext context) {
    Scaffold.of(context).showBottomSheet((context) => _AboutDialog());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          aboutPage,
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      body: Column(
        children: [
          Builder(builder: (context) {
            return RaisedButton(
              onPressed: () => _showAboutDialog(context),
              child: Text(
                'View More',
                style: Theme.of(context).textTheme.button,
              ),
            );
          })
        ],
      ),
    );
  }
}

class _AboutDialog extends StatelessWidget {
  const _AboutDialog({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AboutDialog(
      applicationVersion: '0.0.1',
      applicationName: 'HabitFlow',
      applicationLegalese: 'By ThundRX',
      applicationIcon: Image.asset(
        'assets/images/logo.png',
        fit: BoxFit.cover,
        height: 44,
      ),
      children: [
        Text('HabitFlow'),
      ],
    );
  }
}
