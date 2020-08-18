import 'dart:math';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/foundation.dart';

import 'package:habitflow/services/analytics/analytics.dart';

final Random _random = Random();
const String _appID = 'ca-app-pub-5935597695294717~4847422484';
const String _interstitialID = 'ca-app-pub-5935597695294717/6275521390';
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
    if (kIsWeb || !kReleaseMode) return;
    FirebaseAdMob.instance.initialize(appId: _appID);
  }

  /// Marks [_shouldShow] as false for 5 seconds, then marks as true.
  Future<void> _isShowing() async {
    _shouldShow = false;
    await Future.delayed(const Duration(seconds: 5));
    _shouldShow = true;
  }

  /// Shows an interstitial ad with probability of [chance]%.
  void interstitial([double chance = 30]) {
    if (kIsWeb || !kReleaseMode || !_shouldShow) return;

    if (_random.nextInt(100) <= chance) {
      _isShowing();
      InterstitialAd(
        adUnitId: _interstitialID,
        targetingInfo: _targetingInfo,
      )
        ..load()
        ..show()
        ..dispose();
      Analytics().logSimple('interstitial_ad_shown');
    }
  }
}
