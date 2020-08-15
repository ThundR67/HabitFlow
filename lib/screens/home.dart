import 'package:flutter/material.dart';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:firebase_admob/firebase_admob.dart';

import 'package:habitflow/helpers/ads.dart';
import 'package:habitflow/resources/icons.dart';
import 'package:habitflow/resources/strings.dart';
import 'package:habitflow/screens/cycles.dart';
import 'package:habitflow/screens/rewards.dart';
import 'package:habitflow/screens/today.dart';

/// A page which has bottom navigation bar and shows all main pages.
class Home extends StatefulWidget {
  /// Constructs.
  Home();

  final List<Widget> _pages = const [
    Cycles(),
    Today(),
    Rewards(),
  ];

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 1;

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(appId: appID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(child: widget._pages[_currentIndex]),
      bottomNavigationBar: _BottomNavigationBar(
        currentIndex: _currentIndex,
        onChange: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}

class _BottomNavigationBar extends StatelessWidget {
  const _BottomNavigationBar({
    @required this.currentIndex,
    @required this.onChange,
  });

  final int currentIndex;
  final Function(int) onChange;

  @override
  Widget build(BuildContext context) {
    return BottomNavyBar(
      selectedIndex: currentIndex,
      backgroundColor:
          Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      onItemSelected: onChange,
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
    );
  }
}
