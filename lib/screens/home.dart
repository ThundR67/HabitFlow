import 'package:flutter/material.dart';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';

import 'package:habitflow/resources/behaviour.dart';
import 'package:habitflow/resources/icons.dart';
import 'package:habitflow/resources/strings.dart';
import 'package:habitflow/screens/cycles.dart';
import 'package:habitflow/screens/rewards.dart';
import 'package:habitflow/screens/today.dart';

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
    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: PageView(
            physics: scrollPhysics,
            controller: _pageController,
            onPageChanged: (int index) => setState(() => _currentIndex = index),
            children: const <Widget>[
              Cycles(),
              Today(),
              Rewards(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        showElevation: true,
        backgroundColor:
            Theme.of(context).bottomNavigationBarTheme.backgroundColor,
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
