import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:habitflow/blocs/rewards_bloc.dart';
import 'package:habitflow/blocs/points_bloc.dart';
import 'package:habitflow/screens/home.dart';

void main() {
  runApp(
    MultiProvider(
      providers: <ChangeNotifierProvider<dynamic>>[
        ChangeNotifierProvider<RewardsBloc>(create: (_) => RewardsBloc()),
        ChangeNotifierProvider<PointsBloc>(create: (_) => PointsBloc()),
      ],
      child: const MaterialApp(
        home: Home(),
      ),
    ),
  );
}
