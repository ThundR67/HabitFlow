import 'package:flutter/cupertino.dart';

import 'package:logger/logger.dart';

import 'package:habitflow/helpers/logger.dart';
import 'package:habitflow/helpers/notifications.dart';
import 'package:habitflow/models/habit.dart';
import 'package:habitflow/services/habits/habits.dart';

/// Bloc that will manage all notifications.
class NotificationBloc extends ChangeNotifier {
  final HabitsDAO _habitsDAO = HabitsDAO();
  final Notifications _notifications = Notifications();
  final Logger _log = logger('NotificationBloc');

  /// Updates.
  NotificationBloc() {
    _notifications.init((_) async {}).whenComplete(() {
      _log.i('Initialized notifications');
      update();
    });
  }

  /// Updates by cancelling all notifications and recreating them.
  Future update() async {
    await _notifications.cancel();
    await _habitNotifications();
    _log.i('Updated notifications');
  }

  /// Sets up all the notifications for all habits.
  Future _habitNotifications() async {
    final List<Habit> habits = (await _habitsDAO.all()).values.toList();
    for (final habit in habits) {
      _notifications.setForHabit(habit);
      _log.d('Setted habit notification for ${habit.name}');
    }
    _log.i('Setted habit notifications for all habits');
  }
}
