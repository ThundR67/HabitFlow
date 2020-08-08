import 'package:flutter/scheduler.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:habitflow/resources/themes.dart';
import 'package:theme_provider/theme_provider.dart';

/// Callback when theme provider initializes.
Future<void> themeCallback(
    ThemeController controller, Future<String> prev) async {
  final String savedTheme = await prev;

  if (savedTheme != null) {
    controller.setTheme(savedTheme);
    return;
  }

  final Brightness platformBrightness =
      SchedulerBinding.instance.window.platformBrightness;
  if (platformBrightness == Brightness.dark) {
    controller.setTheme('dark');
  } else {
    controller.setTheme('light');
  }

  controller.forgetSavedTheme();
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
