import 'dart:math';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/foundation.dart';

import 'package:habitflow/helpers/analytics.dart';

/// App id for admob.
const String appID = 'ca-app-pub-5935597695294717~4847422484';

/// Id for interstitial ad.
final String interstitialAdId = InterstitialAd.testAdUnitId;

/// Mobile targeting info.
const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  keywords: [
    'habit',
    'habits',
    'habit tracker',
    'self improvement',
    'motivation',
  ],
);

/// 30% chance of showing interstrial ad.
void showInterstitialAd() {
  if (kReleaseMode) {
    final Random rand = Random();
    if (rand.nextInt(99) < 30) {
      InterstitialAd(
        adUnitId: 'ca-app-pub-5935597695294717/6275521390',
        targetingInfo: targetingInfo,
      )
        ..load()
        ..show()
        ..dispose();
      analytics.logEvent(name: 'interstitial_ad_shown');
    }
  }
}
