import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:habitflow/models/habit.dart';
import 'package:habitflow/helpers/time.dart';

Random _random = Random();

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

  /// Schedules notifications for a [habit].
  Future<void> setForHabit(Habit habit) async {
    if (habit.goal.notificationTimes.isEmpty) return;

    for (final day in habit.goal.activeDays) {
      await _plugin.showWeeklyAtDayAndTime(
        _random.nextInt(9999),
        'Reminder for $habit',
        'Lets go',
        Day.values[day - 1],
        habit.goal.notificationTimes[0].notificationTime(),
        _details,
      );
    }
  }

  /// Cancels all pending notifications.
  Future<void> cancel() async {
    await _plugin.cancelAll();
  }
}
