import 'package:flutter/material.dart';
import 'package:habitflow/helpers/intro.dart';
import 'package:habitflow/resources/routes.dart';
import 'package:habitflow/resources/strings.dart';
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
        title: cycleIntroTitle,
        description: cycleIntroDescription,
        backgroundColor: Colors.blue,
      ),
      Slide(
        title: rewardIntroTitle,
        pathImage: 'assets/images/reward.png',
        description: rewardIntroDescription,
        backgroundColor: Colors.amber[900],
      ),
      Slide(
        title: habitIntroTitle,
        description: habitIntroDescription,
        backgroundColor: Colors.green,
        pathImage: 'assets/images/habit.png',
      ),
      Slide(
        title: journalIntroTitle,
        description: journalIntroDescription,
        backgroundColor: Colors.red,
        pathImage: 'assets/images/journal.png',
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
          introShown(mainIntro);
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          } else {
            Navigator.of(context).pushNamed(homeRoute);
          }
        },
      ),
    );
  }
}
