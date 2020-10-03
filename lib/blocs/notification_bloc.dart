import 'package:flutter/cupertino.dart';
import 'package:habitflow/helpers/notifications.dart';
import 'package:habitflow/models/habit.dart';
import 'package:habitflow/services/habits/habits.dart';

/// Bloc that will manage all notifications.
class NotificationBloc extends ChangeNotifier {
  final HabitsDAO _habitsDAO = HabitsDAO();
  final Notifications _notifications = Notifications();

  /// Updates.
  NotificationBloc() {
    _notifications.init((_) async {}).whenComplete(update);
  }

  /// Updates by cancelling all notifications and recreating them.
  Future update() async {
    await _notifications.cancel();
    await _habitNotifications();
  }

  /// Sets up all the notifications for all habits.
  Future _habitNotifications() async {
    final List<Habit> habits = (await _habitsDAO.all()).values.toList();

    habits.forEach(_notifications.setForHabit);
  }

  /// Cancels all pending notifications.
  Future _cancel() async => _notifications.cancel();
}
