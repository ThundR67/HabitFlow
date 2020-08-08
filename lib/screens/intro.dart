import 'package:flutter/material.dart';
import 'package:habitflow/helpers/intro.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

/// Screen to introduce user to the app.
class Intro extends StatefulWidget {
  /// Constructs.
  const Intro();

  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  final List<Slide> slides = [];
  Function goToTab;

  @override
  void initState() {
    super.initState();

    slides.addAll([
      Slide(
        title: "Cycle",
        description: 'blah blah blah',
        backgroundColor: Colors.blue,
      ),
      Slide(
        title: "Rewards",
        description: 'blah blah blah',
        backgroundColor: Colors.amber[900],
      ),
      Slide(
        title: "Powerful Habit Tracking",
        description: 'blah blah blah',
        backgroundColor: Colors.green,
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: IntroSlider(
        slides: slides,
        shouldHideStatusBar: false,
        colorDot: Colors.white,
        onDonePress: () {
          introShown();
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
