import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:habitflow/blocs/current_bloc.dart';
import 'package:habitflow/blocs/intro_bloc.dart';
import 'package:habitflow/helpers/ads.dart';

import 'package:habitflow/models/cycle.dart';

import 'package:habitflow/resources/icons.dart';
import 'package:habitflow/resources/routes.dart';
import 'package:habitflow/resources/strings.dart';
import 'package:habitflow/resources/widgets.dart';
import 'package:habitflow/screens/cycles.dart';
import 'package:habitflow/screens/rewards.dart';
import 'package:habitflow/screens/today.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

/// A page which has bottom navigation bar and shows all main pages.
class Home extends StatefulWidget {
  /// Constructs.
  const Home();

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 1;
  PageController _pageController;
  final List<Widget> _pages = [
    const Cycles(),
    const Today(),
    Rewards(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
    FirebaseAdMob.instance.initialize(appId: appID);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// Redirects to cycle ended.
  void _redirectToCycleEnded(Cycle cycle) {
    Navigator.of(context).pushReplacementNamed(cycleEndedRoute);
  }

  @override
  Widget build(BuildContext context) {
    final CurrentBloc bloc = Provider.of<CurrentBloc>(context);
    final IntroBloc introBloc = Provider.of<IntroBloc>(context);

    if (bloc.current == null) {
      return const Scaffold(body: circularIndicator);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (bloc.isEnded()) _redirectToCycleEnded(bloc.current);
      if (!introBloc.intros[mainIntro]) {
        Navigator.pushReplacementNamed(context, introRoute);
      }
    });

    return ShowCaseWidget(
      builder: Builder(
        builder: (context) {
          return Scaffold(
            body: ShowCaseWidget(
              builder: Builder(
                builder: (context) =>
                    SizedBox.expand(child: _pages[_currentIndex]),
              ),
            ),
            bottomNavigationBar: BottomNavyBar(
              selectedIndex: _currentIndex,
              backgroundColor:
                  Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              onItemSelected: (int index) => setState(() {
                _currentIndex = index;
              }),
              items: <BottomNavyBarItem>[
                BottomNavyBarItem(
                  icon: const Icon(cycleIcon),
                  title: Text(cyclesPage),
                ),
                BottomNavyBarItem(
                  icon: const Icon(todayIcon),
                  title: Text(todaysPage),
                  activeColor: Colors.red,
                ),
                BottomNavyBarItem(
                  icon: const Icon(rewardIcon),
                  title: Text(rewardsPage),
                  activeColor: Colors.orange,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
