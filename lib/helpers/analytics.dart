import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

/// The main analytics.
final FirebaseAnalytics analytics = FirebaseAnalytics();

/// Navigation observer.
final FirebaseAnalyticsObserver observer =
    FirebaseAnalyticsObserver(analytics: analytics);
