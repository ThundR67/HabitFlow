import 'package:flutter/material.dart';

import 'package:habitflow/services/reward_points/reward_points.dart';

/// A bloc to manage and store user's reward points.
class PointsBloc extends ChangeNotifier {
  /// Creates a bloc and causes an update.
  PointsBloc() {
    _update();
  }

  final RewardPointsDAO _dao = RewardPointsDAO();

  int _points = -1;

  /// Current points of user.
  int get points => _points ?? -1;

  /// Updates [point].
  void _update() {
    _dao.get().then((int value) {
      _points = value;
      notifyListeners();
    });
  }

  /// Increments reward points by [value].
  void increment(int value) {
    _dao.changeBy(value).whenComplete(_update);
  }

  /// Decrement reward points by [value].
  void decrement(int value) {
    _dao.changeBy(-value).whenComplete(_update);
  }
}
