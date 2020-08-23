import 'package:global_configuration/global_configuration.dart';

///
final String admobAppID = GlobalConfiguration().getString('admob_app_id');

///
final String admobInterstitialID =
    GlobalConfiguration().getString('admob_interstitial_id');

///
final int admobAdRate = GlobalConfiguration().getInt('admob_ad_rate');
