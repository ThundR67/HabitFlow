import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
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
      child: const NeumorphicApp(
        themeMode: ThemeMode.dark,
        materialDarkTheme: NeumorphicThemeData.dark(
          baseColor: Color(0xFF3E3E3E),
          shadowDarkColor: Colors.black87,
          shadowLightColor: Colors.grey,
          lightSource: LightSource.topLeft,
          depth: 3,
          intensity: 0.7,
        ),
        home: Home(),
      ),
    ),
  );
}
