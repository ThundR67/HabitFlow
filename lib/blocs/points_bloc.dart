import 'package:flutter/material.dart';
import 'package:habitflow/helpers/logger.dart';

import 'package:hive/hive.dart';
import 'package:logger/logger.dart';

const String _dbName = 'reward_points';

/// A bloc to manage and store user's reward points.
class PointsBloc extends ChangeNotifier {
  /// Reward points of user.
  int points;
  Future<Box<int>> get _db async => Hive.openBox(_dbName);
  final Logger _log = logger('PointsBloc');

  /// Creates a bloc and causes an update.
  PointsBloc() {
    _update();
  }

  /// Updates [point].
  Future<void> _update() async {
    points = (await _db).get(_dbName) ?? 0;
    _log.i('Updated points: $points');
    notifyListeners();
  }

  /// Changes [points] by [value].
  Future<void> changeBy(int value) async {
    points += value;
    notifyListeners();
    _log.i('Points changed by: $value');
    (await _db).put(_dbName, points);
  }

  /// Resets [points] to 0.
  Future<void> reset() async {
    _log.i('Points reset');
    points = 0;
    notifyListeners();
    (await _db).put(_dbName, 0);
  }
}
