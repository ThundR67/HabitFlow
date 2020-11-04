import 'package:flutter/material.dart';

import 'package:logger/logger.dart';

import 'package:habitflow/helpers/logger.dart';
import 'package:habitflow/services/intro/intro.dart';

/// Main app intro.
const mainIntro = 'main';

/// Intro for swipping habits.
const habitIntro = 'habit';

/// Intro for swipping rewards.
const rewardIntro = 'reward';

/// Intro for cycle data.
const cycleIntro = 'cycle';

/// List of all intros.
const List<String> allIntros = [
  mainIntro,
  habitIntro,
  rewardIntro,
  cycleIntro,
];

/// This bloc will manage if all intros are shown or not.
class IntroBloc extends ChangeNotifier {
  /// Value of all intros.
  Map<String, bool> intros;
  final IntroDAO _dao = IntroDAO();
  final Logger _log = logger('IntroBloc');

  /// Fills up [intros].
  IntroBloc() {
    intros = {};
    for (final intro in allIntros) {
      _dao.isShown(intro).then((value) => intros[intro] = value);
    }
    _log.i('Lodaded all intros');
    notifyListeners();
  }

  /// Sets [name] as shown.
  Future<void> shown(String name) async {
    _log.i('Intro shown $name');
    intros[name] = true;
    notifyListeners();
    await _dao.introShown(name);
  }
}
