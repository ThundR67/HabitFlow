import 'package:flutter/material.dart';
import 'package:habitflow/blocs/intro_bloc.dart';
import 'package:habitflow/resources/routes.dart';
import 'package:habitflow/resources/strings.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:provider/provider.dart';

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

  /// Returna a [Slide] object.
  Slide _slide(String title, String description, String image, Color color) {
    return Slide(
      title: title,
      marginDescription: EdgeInsets.all(16.0),
      description: description,
      backgroundColor: color,
      pathImage: 'assets/images/$image',
      maxLineTitle: 2,
    );
  }

  @override
  void initState() {
    super.initState();

    slides.addAll([
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
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      slides: slides,
      shouldHideStatusBar: false,
      colorDot: Colors.white,
      onDonePress: () {
        Provider.of<IntroBloc>(context, listen: false).shown(mainIntro);
        Navigator.of(context).pushReplacementNamed(homeRoute);
      },
    );
  }
}
