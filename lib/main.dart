import 'dart:io';

import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'package:habitflow/blocs/current_bloc.dart';
import 'package:habitflow/blocs/cycles_bloc.dart';
import 'package:habitflow/blocs/habits_bloc.dart';
import 'package:habitflow/blocs/intro_bloc.dart';
import 'package:habitflow/blocs/points_bloc.dart';
import 'package:habitflow/blocs/rewards_bloc.dart';
import 'package:habitflow/blocs/theme_bloc.dart';
import 'package:habitflow/helpers/analytics.dart';
import 'package:habitflow/models/cycle.dart';
import 'package:habitflow/models/day.dart';
import 'package:habitflow/models/goal.dart';
import 'package:habitflow/models/habit.dart';
import 'package:habitflow/models/reward.dart';
import 'package:habitflow/models/time_of_day.g.dart';
import 'package:habitflow/resources/routes.dart';
import 'package:habitflow/routes.dart';

Future<void> main() async {
  Hive.registerAdapter(RewardAdapter());
  Hive.registerAdapter(CycleAdapter());
  Hive.registerAdapter(HabitAdapter());
  Hive.registerAdapter(GoalAdapter());
  Hive.registerAdapter(DayAdapter());
  Hive.registerAdapter(TimeAdapter());
  WidgetsFlutterBinding.ensureInitialized();
  final Directory dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);

  runApp(
    MultiProvider(
      providers: <ChangeNotifierProvider<dynamic>>[
        ChangeNotifierProvider<RewardsBloc>(create: (_) => RewardsBloc()),
        ChangeNotifierProvider<PointsBloc>(create: (_) => PointsBloc()),
        ChangeNotifierProvider<HabitsBloc>(create: (_) => HabitsBloc()),
        ChangeNotifierProvider<CyclesBloc>(create: (_) => CyclesBloc()),
        ChangeNotifierProvider<CurrentBloc>(create: (_) => CurrentBloc()),
        ChangeNotifierProvider<IntroBloc>(create: (_) => IntroBloc()),
        ChangeNotifierProvider<ThemeBloc>(create: (_) => ThemeBloc()),
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
    final ThemeBloc bloc = Provider.of<ThemeBloc>(context);
    return MaterialApp(
      navigatorObservers: [observer],
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: bloc.themes[bloc.current],
      themeMode: ThemeMode.light,
      initialRoute: loadingRoute,
      routes: routes,
      color: Colors.white,
    );
  }
}
