import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:habitflow/helpers/notifications.dart';
import 'package:habitflow/helpers/quotes.dart';
import 'package:habitflow/models/habit.dart';
import 'package:habitflow/resources/strings.dart';
import 'package:habitflow/services/analytics/analytics.dart';
import 'package:habitflow/services/habits/habits.dart';

/// A Bloc which manages user's habits.
class HabitsBloc extends ChangeNotifier {
  /// Causes a update as soon as bloc is initialized.
  HabitsBloc() {
    _notifications.init(null).whenComplete(_update);
  }

  final HabitsDAO _dao = HabitsDAO();
  final Notifications _notifications = Notifications();

  /// All the habits.
  Map<String, Habit> habits;

  /// Sets notifications for all habits.
  Future<void> _setNotifications() async {
    await _notifications.cancel();
    habits.values.forEach(_setNotificationsFor);
  }

  /// Sets up notifications for [habit].
  Future<void> _setNotificationsFor(Habit habit) async {
    if (habit.goal.notificationTimes.isEmpty) return;
    if (habit.goal.activeDays.isEmpty) return;

    final List<Day> days = [
      for (int i in habit.goal.activeDays) Day.values[i - 1]
    ];

    final TimeOfDay time = habit.goal.notificationTimes[0];
    await _notifications.schedule(
      Time(time.hour, time.minute),
      '$remind ${habit.name}',
      randQuote(),
      days,
    );
  }

  /// Updates [habits] and sets up notifications.
  Future<void> _update() async {
    habits = await _dao.all();
    notifyListeners();
    _setNotifications();
  }

  /// Adds [habit] into db.
  Future<void> add(Habit habit) async {
    await _dao.add(habit);
    await _update();
    Analytics().logHabit('habit_added', habit);
  }

  /// Deletes [habit]t from db.
  Future<void> delete(Habit habit) async {
    await _dao.delete(habit);
    await _update();
    Analytics().logHabit('habit_ended', habit);
  }

  @override
  void dispose() {
    super.dispose();
    _dao.close();
  }
}
