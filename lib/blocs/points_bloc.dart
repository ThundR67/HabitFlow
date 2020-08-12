import 'package:flutter/material.dart';

import 'package:habitflow/services/reward_points/reward_points.dart';

/// A bloc to manage and store user's reward points.
class PointsBloc extends ChangeNotifier {
  /// Creates a bloc and causes an update.
  PointsBloc() {
    _update();
  }

  final RewardPointsDAO _dao = RewardPointsDAO();

  /// Reward points of user.
  int points;

  /// Updates [point].
  Future<void> _update() async {
    points = await _dao.get();
    notifyListeners();
  }

  /// Increments reward points by [value].
  void increment(int value) {
    _dao.changeBy(value);
    points += value;
    notifyListeners();
  }

  /// Decrement reward points by [value].
  void decrement(int value) => increment(-value);

  @override
  void dispose() {
    super.dispose();
    _dao.close();
  }
}
