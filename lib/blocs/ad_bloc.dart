import 'dart:math';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/foundation.dart';
import 'package:habitflow/resources/configs.dart';

import 'package:habitflow/services/analytics/analytics.dart';

final Random _random = Random();
const MobileAdTargetingInfo _targetingInfo = MobileAdTargetingInfo(
  keywords: [
    'habit',
    'habits',
    'habit tracker',
    'self improvement',
    'motivation',
  ],
);

/// A BLOC to manage ads.
class AdBloc {
  bool _shouldShow = true;

  /// Initializes admob if not web.
  AdBloc() {
    if (kIsWeb) return;
    FirebaseAdMob.instance.initialize(appId: admobAppID);
  }

  /// Marks [_shouldShow] as false for 5 seconds, then marks as true.
  Future<void> _isShowing() async {
    _shouldShow = false;
    await Future.delayed(const Duration(seconds: 5));
    _shouldShow = true;
  }

  /// Shows an interstitial ad with probability of [chance]%.
  void interstitial([double chance]) {
    if (kIsWeb || !_shouldShow) return;

    if (_random.nextInt(100) <= (chance ?? admobAdRate)) {
      _isShowing();
      InterstitialAd(
        adUnitId: admobInterstitialID,
        targetingInfo: _targetingInfo,
      )
        ..load()
        ..show()
        ..dispose();
      Analytics().logSimple('interstitial_ad_shown');
    }
  }
}
