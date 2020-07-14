import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:habitflow/blocs/rewards_bloc.dart';
import 'package:habitflow/blocs/points_bloc.dart';
import 'package:habitflow/screens/home.dart';
import 'package:habitflow/screens/created_reward.dart';

void main() {
  runApp(
    MultiProvider(
      providers: <ChangeNotifierProvider<dynamic>>[
        ChangeNotifierProvider<RewardsBloc>(create: (_) => RewardsBloc()),
        ChangeNotifierProvider<PointsBloc>(create: (_) => PointsBloc()),
      ],
      child: MaterialApp(
        themeMode: ThemeMode.dark,
        theme: ThemeData.dark(),
        initialRoute: '/home',
        routes: <String, Widget Function(BuildContext)>{
          '/home': (BuildContext context) => const Home(),
          '/create_reward': (BuildContext context) => const CreateReward(),
        },
      ),
    ),
  );
}
