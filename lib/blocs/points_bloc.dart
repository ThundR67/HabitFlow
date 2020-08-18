import 'package:flutter/material.dart';

import 'package:hive/hive.dart';

const String _dbName = 'reward_points';

/// A bloc to manage and store user's reward points.
class PointsBloc extends ChangeNotifier {
  /// Creates a bloc and causes an update.
  PointsBloc() {
    _update();
  }

  Future<Box<int>> get _db async => Hive.openBox(_dbName);

  /// Reward points of user.
  int points;

  /// Updates [point].
  Future<void> _update() async {
    points = (await _db).get(_dbName);
    notifyListeners();
  }

  /// Changes [points] by [value].
  Future<void> changeBy(int value) async {
    points += value;
    notifyListeners();
    (await _db).put(_dbName, points);
  }

  /// Resets [points] to 0.
  Future<void> reset() async {
    points = 0;
    notifyListeners();
    (await _db).put(_dbName, 0);
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    (await _db).close();
  }
}
