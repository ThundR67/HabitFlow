import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:habitflow/models/habit.dart';
import 'package:habitflow/models/reward.dart';

/// A class to manage firebase analytics.
class Analytics {
  /// Returns the [_singleton] instance of Analytics.
  factory Analytics() => _singleton;
  static final Analytics _singleton = Analytics._();
  FirebaseAnalytics _analytics;
  Analytics._();

  /// Initializes firebase analytics.
  void init() => _analytics = FirebaseAnalytics();

  /// Returns an oberser for firebase analytics.
  FirebaseAnalyticsObserver observer() {
    return FirebaseAnalyticsObserver(analytics: _analytics);
  }

  /// Logs an simple event with [name].
  void logSimple(String name, [Map<String, dynamic> map]) {
    _analytics.logEvent(name: name, parameters: map);
  }

  /// Logs a reward with event [name].
  void logHabit(String name, Habit habit) {
    _analytics.logEvent(
      name: name,
      parameters: habit.toLog(),
    );
  }

  /// Logs a reward with event [name].
  void logReward(String name, Reward reward) {
    _analytics.logEvent(
      name: name,
      parameters: reward.toLog(),
    );
  }
}
