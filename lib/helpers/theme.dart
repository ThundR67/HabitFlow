import 'package:flutter/scheduler.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:habitflow/resources/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theme_provider/theme_provider.dart';

const String _dark = 'dark';
const String _light = 'light';
const String _system = '_system';
const String _theme = 'theme';

/// Sets theme to [theme] and saves it.
Future<void> _setTheme(String theme) async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  await pref.setString(_theme, theme);
}

/// Gets current theme.
Future<ThemeMode> getTheme() async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  final String theme = pref.getString(_theme) ?? _system;
  if (theme == _dark) return ThemeMode.dark;
  if (theme == _light) return ThemeMode.light;
  return ThemeMode.system;
}

/// Callback when theme provider initializes.
Future<void> themeCallback(ThemeController controller, _) async {
  final ThemeMode saved = await getTheme();
  if (ThemeMode.dark == saved) setDark(controller);
  if (ThemeMode.light == saved) setLight(controller);
  if (ThemeMode.system == saved) setSystem(controller);
}

/// Sets theme to light.
Future<void> setLight(ThemeController controller) async {
  controller.setTheme(_light);
  await _setTheme(_light);
}

/// Sets theme to dark.
Future<void> setDark(ThemeController controller) async {
  controller.setTheme(_dark);
  await _setTheme(_dark);
}

/// Sets theme to system by forgetting saved theme.
Future<void> setSystem(ThemeController controller) async {
  final Brightness brightness =
      SchedulerBinding.instance.window.platformBrightness;
  if (brightness == Brightness.dark) {
    controller.setTheme(_dark);
  } else {
    controller.setTheme(_light);
  }
  await _setTheme(_system);
}

/// Returns a list of app themes.
List<AppTheme> themes() {
  return [
    AppTheme(
      id: 'light',
      data: lightTheme(),
      description: '',
    ),
    AppTheme(
      id: 'dark',
      data: darkTheme(),
      description: '',
    ),
  ];
}
