import 'dart:math';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:habitflow/helpers/analytics.dart';

/// App id for admob.
const String appID = 'ca-app-pub-3940256099942544~3347511713';

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
  final Random rand = Random();
  if (rand.nextInt(99) < 30) {
    InterstitialAd(
      adUnitId: interstitialAdId,
      targetingInfo: targetingInfo,
    )
      ..load()
      ..show()
      ..dispose();
    analytics.logEvent(name: 'interstitial_ad_shown');
  }
}
