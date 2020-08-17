import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/foundation.dart';
import 'package:habitflow/models/habit.dart';
import 'package:habitflow/models/reward.dart';

/// A class to manage firebase analytics.
class Analytics {
  /// Returns the [_singleton] instance of Analytics.
  factory Analytics() => _singleton;
  static final Analytics _singleton = Analytics._();
  Analytics._();

  FirebaseAnalytics _analytics;

  /// Initializes firebase analytics.
  void init() {
    if (!kIsWeb) _analytics = FirebaseAnalytics();
  }

  /// Returns an oberser for firebase analytics.
  FirebaseAnalyticsObserver observer() {
    if (!kIsWeb) return null;
    return FirebaseAnalyticsObserver(analytics: _analytics);
  }

  /// Logs an simple event with [name].
  void logSimple(String name) {
    if (kIsWeb) return;
    _analytics.logEvent(name: name);
  }

  /// Logs a reward with event [name].
  void logHabit(String name, Habit habit) {
    if (kIsWeb) return;
    _analytics.logEvent(
      name: name,
      parameters: {
        'name': habit.name,
        'points': habit.points,
      },
    );
  }

  /// Logs a reward with event [name].
  void logReward(String name, Reward reward) {
    if (kIsWeb) return;
    _analytics.logEvent(
      name: name,
      parameters: {
        'name': reward.name,
        'points': reward.points,
        'amount_taken': reward.amountTaken,
      },
    );
  }
}
