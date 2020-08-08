import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:habitflow/resources/routes.dart';
import 'package:provider/provider.dart';

import 'package:habitflow/blocs/current_bloc.dart';
import 'package:habitflow/blocs/cycles_bloc.dart';
import 'package:habitflow/blocs/habits_bloc.dart';
import 'package:habitflow/blocs/points_bloc.dart';
import 'package:habitflow/blocs/rewards_bloc.dart';
import 'package:habitflow/resources/themes.dart';
import 'package:habitflow/screens/create_habit.dart';
import 'package:habitflow/screens/create_reward.dart';
import 'package:habitflow/screens/home.dart';

Future<void> main() async {
  runApp(
    MultiProvider(
      providers: <ChangeNotifierProvider<dynamic>>[
        ChangeNotifierProvider<RewardsBloc>(create: (_) => RewardsBloc()),
        ChangeNotifierProvider<PointsBloc>(create: (_) => PointsBloc()),
        ChangeNotifierProvider<HabitsBloc>(create: (_) => HabitsBloc()),
        ChangeNotifierProvider<CyclesBloc>(create: (_) => CyclesBloc()),
        ChangeNotifierProvider<CurrentBloc>(create: (_) => CurrentBloc()),
      ],
      child: EasyLocalization(
        supportedLocales: const <Locale>[Locale('en')],
        path: 'assets/translations',
        child: const App(),
      ),
    ),
  );
}

/// The main app.
class App extends StatelessWidget {
  /// Constructs.
  const App();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      darkTheme: darkTheme(),
      theme: lightTheme(),
      initialRoute: homeRoute,
      routes: <String, Widget Function(BuildContext)>{
        homeRoute: (BuildContext context) => const Home(),
        createRewardRoute: (BuildContext context) => const CreateReward(),
        createHabitRoute: (BuildContext context) => const CreateHabit(),
      },
    );
  }
}
