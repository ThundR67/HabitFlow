import 'package:shared_preferences/shared_preferences.dart';

const String _key = 'isIntroShown';

/// Returns if intro screen was shown.
Future<bool> isIntroShown() async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getBool(_key) ?? false;
}

/// Marks intro shown as true.
Future<void> introShown() async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  await pref.setBool(_key, true);
}
