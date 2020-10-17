import 'package:flutter/material.dart';
import 'package:habitflow/blocs/ad_bloc.dart';

import 'package:habitflow/resources/icons.dart';
import 'package:habitflow/resources/strings.dart';
import 'package:habitflow/screens/cycles.dart';
import 'package:habitflow/screens/rewards.dart';
import 'package:habitflow/screens/today.dart';
import 'package:provider/provider.dart';

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
    Provider.of<AdBloc>(context, listen: false).interstitial();
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (index) => setState(() => _currentIndex = index),
          children: const [
            Cycles(),
            Today(),
            Rewards(),
          ],
        ),
      ),
      bottomNavigationBar: _BottomNavigationBar(
        currentIndex: _currentIndex,
        onChange: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
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
    return BottomNavigationBar(
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
    );
  }
}
