import 'package:flutter/material.dart';

/// Screen to introduce user to the app.
class Intro extends StatefulWidget {
  /// Constructs.
  const Intro();

  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: Text('test')),
    );
  }
}
