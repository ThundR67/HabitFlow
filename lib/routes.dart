import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:habitflow/resources/routes.dart';
import 'package:habitflow/screens/create_habit.dart';
import 'package:habitflow/screens/create_reward.dart';
import 'package:habitflow/screens/cycle_ended.dart';
import 'package:habitflow/screens/faq.dart';
import 'package:habitflow/screens/home.dart';
import 'package:habitflow/screens/intro.dart';
import 'package:habitflow/screens/loading.dart';

/// Routes to all screen.
final Map<String, Widget Function(BuildContext)> routes = {
  homeRoute: (_) => const Home(),
  createRewardRoute: (_) => const CreateReward(),
  createHabitRoute: (_) => const CreateHabit(),
  cycleEndedRoute: (_) => const CycleEnded(),
  faqRoute: (_) => const FAQ(),
  introRoute: (_) => const Intro(),
  loadingRoute: (_) => const Loading(),
};
