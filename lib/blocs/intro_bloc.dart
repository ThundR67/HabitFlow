import 'package:flutter/material.dart';
import 'package:habitflow/services/intro/intro.dart';

/// Main app intro.
const mainIntro = 'main';

/// Intro for swipping habits.
const habitIntro = 'habit';

/// Intro for swipping rewards.
const rewardIntro = 'reward';

/// List of all intros.
const List<String> allIntros = [mainIntro, habitIntro, rewardIntro];

/// This bloc will manage if all intros are shown or not.
class IntroBloc extends ChangeNotifier {
  /// Constructs.
  IntroBloc() {
    _update();
  }

  final IntroDAO _dao = IntroDAO();

  /// Value of all intros.
  Map<String, bool> intros;

  /// Updates [intros].
  Future<void> _update() async {
    intros = {};
    for (final String intro in allIntros) {
      intros[intro] = await _dao.isShown(intro);
    }
    notifyListeners();
  }

  /// Sets [name] as shown.
  Future<void> shown(String name) async {
    intros[name] = true;
    notifyListeners();
    await _dao.introShown(name);
  }
}
