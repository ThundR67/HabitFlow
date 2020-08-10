import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Class to help with notifications.
class Notifications {
  FlutterLocalNotificationsPlugin _plugin;
  AndroidInitializationSettings _android;
  IOSInitializationSettings _ios;
  InitializationSettings _settings;
  NotificationDetails _details;

  /// Initializes notifications.
  Notifications() {
    _plugin = FlutterLocalNotificationsPlugin();
    _android = const AndroidInitializationSettings('ic_icon');
    _ios = const IOSInitializationSettings();
    _settings = InitializationSettings(_android, _ios);
    const AndroidNotificationDetails andDetails = AndroidNotificationDetails(
      '1234',
      'habitflow',
      'test',
      importance: Importance.Max,
      priority: Priority.High,
      ticker: 'ticker',
    );
    _details = const NotificationDetails(andDetails, null);
  }

  /// Initializes notifications.
  Future<void> init(Future<void> Function(String) onSelect) async {
    await _plugin.initialize(_settings, onSelectNotification: onSelect);
  }

  /// Schedules notifications at [days].
  Future<void> schedule(
    Time time,
    String title,
    String body,
    List<Day> days,
  ) async {
    final Random rand = Random();
    for (final Day day in days) {
      await _plugin.showWeeklyAtDayAndTime(
        rand.nextInt(10000),
        title,
        body,
        day,
        time,
        _details,
      );
    }
  }

  /// Cancels all pending notifications.
  Future<void> cancel() async {
    await _plugin.cancelAll();
  }
}
