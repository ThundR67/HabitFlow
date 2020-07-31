import 'dart:math';

import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

import 'package:habitflow/blocs/current_cycle_bloc.dart';
import 'package:habitflow/blocs/cycles_bloc.dart';
import 'package:habitflow/blocs/habits_bloc.dart';
import 'package:habitflow/blocs/points_bloc.dart';
import 'package:habitflow/blocs/rewards_bloc.dart';
import 'package:habitflow/screens/create_habit.dart';
import 'package:habitflow/screens/create_reward.dart';
import 'package:habitflow/screens/home.dart';
import 'package:habitflow/services/quotes/quotes.dart';

void main() {
  runApp(
    MultiProvider(
      providers: <ChangeNotifierProvider<dynamic>>[
        ChangeNotifierProvider<RewardsBloc>(create: (_) => RewardsBloc()),
        ChangeNotifierProvider<PointsBloc>(create: (_) => PointsBloc()),
        ChangeNotifierProvider<HabitsBloc>(create: (_) => HabitsBloc()),
        ChangeNotifierProvider<CyclesBloc>(create: (_) => CyclesBloc()),
        ChangeNotifierProvider<CurrentCycleBloc>(
          create: (_) => CurrentCycleBloc(),
        ),
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
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData.dark(),
      initialRoute: '/home',
      routes: <String, Widget Function(BuildContext)>{
        '/home': (BuildContext context) =>
            Home(Random().nextInt(quotes.length)),
        '/create_reward': (BuildContext context) => const CreateReward(),
        '/create_habit': (BuildContext context) => const CreateHabit(),
      },
    );
  }
}
