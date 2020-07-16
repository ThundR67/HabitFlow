import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:habitflow/blocs/habits_bloc.dart';
import 'package:habitflow/services/quotes/quotes.dart';
import 'package:provider/provider.dart';

import 'package:habitflow/blocs/points_bloc.dart';
import 'package:habitflow/blocs/rewards_bloc.dart';
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
  int _currentIndex = 2;
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

    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (int index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            Container(color: Colors.blue),
            Today(habitsBloc, _quoteID),
            Rewards(rewardsBloc, pointsBloc),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        backgroundColor: Colors.black,
        showElevation: true,
        onItemSelected: (int index) => setState(() {
          _currentIndex = index;
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        }),
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: const Icon(Icons.refresh),
            title: const Text('Cycles'),
            activeColor: Colors.blue,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.today),
            title: const Text('Today'),
            activeColor: Colors.red,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.star),
            title: const Text('Rewards'),
            activeColor: Colors.yellow,
          ),
        ],
      ),
    );
  }
}
