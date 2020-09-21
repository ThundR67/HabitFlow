import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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

  final List<Widget> _pages = const [
    Cycles(),
    Today(),
    Rewards(),
  ];

  @override
  Widget build(BuildContext context) {
    // TODO Indexed stack
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: _BottomNavigationBar(
        currentIndex: _currentIndex,
        onChange: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}

/// A circular bottom bar.
class _BottomNavigationBar extends StatelessWidget {
  const _BottomNavigationBar({
    @required this.currentIndex,
    @required this.onChange,
  });

  final int currentIndex;
  final Function(int) onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: Theme.of(context).bottomNavigationBarTheme.elevation,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(16.0),
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onChange,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const Icon(cycleIcon),
              title: Text(cyclesPage),
            ),
            BottomNavigationBarItem(
              icon: const Icon(todayIcon),
              title: Text(todaysPage),
            ),
            BottomNavigationBarItem(
              icon: const Icon(rewardIcon),
              title: Text(rewardsPage),
            ),
          ],
        ),
      ),
    );
  }
}
