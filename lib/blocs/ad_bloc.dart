import 'dart:math';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/foundation.dart';

import 'package:habitflow/services/analytics/analytics.dart';

/// App id for admob.
const String _appID = 'ca-app-pub-5935597695294717~4847422484';

/// Id for interstitial ad.
const String _interstitialAdId = 'ca-app-pub-5935597695294717/6275521390';

/// Mobile targeting info.
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
  /// Initializes admob if not web and if release mode.
  AdBloc() {
    if (!kIsWeb) {
      FirebaseAdMob.instance.initialize(
        appId: kReleaseMode ? _appID : FirebaseAdMob.testAppId,
      );
    }
  }

  bool _shouldShow = true;

  /// Makrs [_shouldShow] as true for 5 seconds.
  Future<void> _isShowing() async {
    _shouldShow = false;
    await Future.delayed(const Duration(seconds: 5));
    _shouldShow = true;
  }

  /// Shows an interstitial ad with probability of [chance].
  void interstitial([double chance = 0.3]) {
    if (_shouldShow && !kIsWeb) {
      _isShowing();
      final Random rand = Random();
      if (rand.nextInt(99) < (100 * (kReleaseMode ? chance : 1))) {
        InterstitialAd(
          adUnitId:
              kReleaseMode ? _interstitialAdId : InterstitialAd.testAdUnitId,
          targetingInfo: _targetingInfo,
        )
          ..load()
          ..show()
          ..dispose();
        //Analytics().logSimple('interstitial_ad_shown');
      }
    }
  }
}
