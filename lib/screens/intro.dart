import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:provider/provider.dart';

import 'package:habitflow/blocs/intro_bloc.dart';
import 'package:habitflow/resources/routes.dart';
import 'package:habitflow/resources/strings.dart';

/// Returna a [Slide] object.
Slide _slide(String title, String description, String image, Color color) {
  return Slide(
    title: title,
    marginDescription: const EdgeInsets.all(16.0),
    description: description,
    backgroundColor: color,
    pathImage: 'assets/images/$image',
    maxLineTitle: 2,
  );
}

/// Screen to introduce user to the app.
class Intro extends StatefulWidget {
  /// Constructs.
  Intro();
  final List<Slide> _slides = [
    _slide(
      cycleIntroTitle,
      cycleIntroDescription,
      'cycle.png',
      Colors.blue,
    ),
    _slide(
      rewardIntroTitle,
      rewardIntroDescription,
      'reward.png',
      Colors.amber[900],
    ),
    _slide(
      journalIntroTitle,
      journalIntroDescription,
      'journal.png',
      Colors.red,
    ),
    _slide(
      habitIntroTitle,
      habitIntroDescription,
      'habit.png',
      Colors.green,
    ),
    _slide(
      newYouTitle,
      newYouDescription,
      'new_you.png',
      Colors.purple,
    ),
  ];

  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  Function goToTab;
  NavigatorState _navigator;

  @override
  void initState() {
    super.initState();
    _navigator = Navigator.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      slides: widget._slides,
      shouldHideStatusBar: false,
      colorDot: Colors.white,
      onDonePress: () {
        Provider.of<IntroBloc>(context, listen: false).shown(mainIntro);
        _navigator.pushReplacementNamed(homeRoute);
      },
    );
  }
}
