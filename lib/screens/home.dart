import 'package:flutter/material.dart';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:habitflow/resources/behaviour.dart';
import 'package:provider/provider.dart';

import 'package:habitflow/blocs/current_cycle_bloc.dart';
import 'package:habitflow/blocs/cycles_bloc.dart';
import 'package:habitflow/blocs/habits_bloc.dart';
import 'package:habitflow/blocs/points_bloc.dart';
import 'package:habitflow/blocs/rewards_bloc.dart';
import 'package:habitflow/resources/icons.dart';
import 'package:habitflow/resources/strings.dart';
import 'package:habitflow/screens/cycles.dart';
import 'package:habitflow/screens/rewards.dart';
import 'package:habitflow/screens/today.dart';

/// A page which has bottom navigation bar and shows all main pages.
class Home extends StatefulWidget {
  /// Constructs
  const Home(this._quoteID, {Key key}) : super(key: key);

  final int _quoteID;

  @override
  _HomeState createState() => _HomeState(_quoteID);
}

class _HomeState extends State<Home> {
  /// Constructs.
  _HomeState(this._quoteID);

  final int _quoteID;
  int _currentIndex = 1;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final PointsBloc pointsBloc = Provider.of<PointsBloc>(context);
    final RewardsBloc rewardsBloc = Provider.of<RewardsBloc>(context);
    final HabitsBloc habitsBloc = Provider.of<HabitsBloc>(context);
    final CyclesBloc cyclesBloc = Provider.of<CyclesBloc>(context);
    final CurrentCycleBloc currentBloc = Provider.of<CurrentCycleBloc>(context);

    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: PageView(
            physics: scrollPhysics,
            controller: _pageController,
            onPageChanged: (int index) {
              setState(() => _currentIndex = index);
            },
            children: <Widget>[
              Cycles(cyclesBloc, currentBloc),
              Today(habitsBloc, currentBloc, _quoteID),
              Rewards(rewardsBloc, pointsBloc),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        backgroundColor: Colors.black,
        showElevation: true,
        onItemSelected: (int index) => setState(() {
          _currentIndex = index;
          _pageController.jumpToPage(index);
        }),
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: const Icon(cycleIcon),
            title: Text(cyclesPage),
            activeColor: Colors.blue,
          ),
          BottomNavyBarItem(
            icon: const Icon(todayIcon),
            title: Text(todaysPage),
            activeColor: Colors.red,
          ),
          BottomNavyBarItem(
            icon: const Icon(rewardIcon),
            title: Text(rewardsPage),
            activeColor: Colors.amber,
          ),
        ],
      ),
    );
  }
}
