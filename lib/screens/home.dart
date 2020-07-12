import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:habitflow/blocs/points_bloc.dart';
import 'package:habitflow/blocs/rewards_bloc.dart';
import 'package:habitflow/screens/rewards.dart';

/// A page which has bottom navigation bar and shows all main pages.
class Home extends StatefulWidget {
  /// Constructs
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 1;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PointsBloc pointsBloc = Provider.of<PointsBloc>(context);
    RewardsBloc rewardsBloc = Provider.of<RewardsBloc>(context);

    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (int index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            Container(color: Colors.blue),
            Container(color: Colors.deepOrange),
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
