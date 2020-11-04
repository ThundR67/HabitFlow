import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sprintf/sprintf.dart';

import 'package:habitflow/helpers/colors.dart';
import 'package:habitflow/helpers/time.dart';
import 'package:habitflow/models/habit.dart';
import 'package:habitflow/resources/strings.dart';

Random _random = Random();

/// Maps int to Day
Day _intToDay(int day) {
  return {
    DateTime.monday: Day.Monday,
    DateTime.tuesday: Day.Tuesday,
    DateTime.wednesday: Day.Wednesday,
    DateTime.thursday: Day.Thursday,
    DateTime.friday: Day.Friday,
    DateTime.saturday: Day.Saturday,
    DateTime.sunday: Day.Sunday,
  }[day];
}

/// Class to help with notifications.
class Notifications {
  FlutterLocalNotificationsPlugin _plugin;
  AndroidInitializationSettings _android;
  IOSInitializationSettings _ios;
  InitializationSettings _settings;

  /// Initializes notifications.
  Notifications() {
    _plugin = FlutterLocalNotificationsPlugin();
    _android = const AndroidInitializationSettings('ic_icon');
    _ios = const IOSInitializationSettings();
    _settings = InitializationSettings(_android, _ios);
  }

  /// Initializes notifications.
  Future<void> init(Future<void> Function(String) onSelect) async {
    await _plugin.initialize(_settings, onSelectNotification: onSelect);
  }

  /// Schedules reminder notification for a [habit].
  Future<void> setForHabit(Habit habit) async {
    if (habit.goal.notificationTimes.isEmpty) return;

    final androidDetails = AndroidNotificationDetails(
      '6767',
      'habitflow',
      'notifications for habitflow',
      color: hexToColor(habit.colorHex),
      importance: Importance.Max,
      priority: Priority.High,
      ticker: 'notifications for habitflow',
    );

    for (final day in habit.goal.activeDays) {
      await _plugin.showWeeklyAtDayAndTime(
        _random.nextInt(9999),
        sprintf(habitNotificationTitle, [habit.name]),
        sprintf(habitNotificationBody, [habit.points]),
        _intToDay(day),
        habit.goal.notificationTimes[0].notificationTime(),
        NotificationDetails(androidDetails, null),
      );
    }
  }

  /// Cancels all pending notifications.
  Future<void> cancel() async {
    await _plugin.cancelAll();
  }
}
