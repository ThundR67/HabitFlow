import 'dart:math';

import 'package:flutter/foundation.dart';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:logger/logger.dart';

import 'package:habitflow/helpers/logger.dart';
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
  InterstitialAd _interstitialAd;
  final Logger _log = logger('AdBloc');

  /// Initializes admob if not web.
  AdBloc() {
    if (kIsWeb) return;
    FirebaseAdMob.instance.initialize(appId: admobAppID);
    _interstitialAd = InterstitialAd(
      adUnitId: admobInterstitialID,
      targetingInfo: _targetingInfo,
      listener: (event) {
        if (event == MobileAdEvent.impression) {
          Analytics().logSimple('interstitial_ad_shown');
        } else if (event == MobileAdEvent.clicked) {
          Analytics().logSimple('interstitial_ad_clicked');
        }
      },
    );
    _log.i('AdBloc Initialized');
  }

  /// Marks [_shouldShow] as false for 5 seconds, then marks as true.
  Future<void> _isShowing() async {
    _log.d('IsShowing Locked');
    _shouldShow = false;
    await Future.delayed(const Duration(seconds: 5));
    _log.d('IsShowing Unlocked');
    _shouldShow = true;
  }

  /// Shows an interstitial ad with probability of [chance]%.
  void interstitial([double chance]) {
    if (kIsWeb || !_shouldShow) return;
    if (_random.nextInt(100) <= (chance ?? admobAdRate)) {
      _log.i('Interstital Ad shown');
      _isShowing();
      _interstitialAd
        ..load()
        ..show();
      return;
    }
    _log.i('Interstitial Ad trigger but not shown');
  }
}
