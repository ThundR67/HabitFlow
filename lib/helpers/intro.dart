import 'package:shared_preferences/shared_preferences.dart';

/// Main intro.
const String mainIntro = 'isIntroShown';

/// Intro for reward points in reward screen.
const String rewardPointsIntro = 'rewardPointsIntro';

/// Returns if intro screen was shown.
Future<bool> isIntroShown(String key) async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getBool(key) ?? false;
}

/// Marks intro shown as true.
Future<void> introShown(String key) async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  await pref.setBool(key, true);
}
