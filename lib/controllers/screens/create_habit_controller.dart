import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:habitflow/blocs/current_bloc.dart';
import 'package:habitflow/blocs/habits_bloc.dart';
import 'package:habitflow/blocs/notification_bloc.dart';
import 'package:habitflow/helpers/colors.dart';
import 'package:habitflow/models/goal.dart';
import 'package:habitflow/models/habit.dart';
import 'package:habitflow/resources/icons.dart';
import 'package:provider/provider.dart';

/// Controller for create habit screen.
class CreateHabitController extends ChangeNotifier {
  /// Key for the form.
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// Controller for habit name.
  TextEditingController nameController;

  /// Controller for habit points.
  TextEditingController pointsController;

  /// List of active days.
  List<int> activeDays;

  /// Habit icon.
  IconData icon;

  /// Habit color.
  Color color;

  /// Notification time.
  TimeOfDay time;

  /// Id of habit.
  String id;

  /// SetState function.
  Function(Function()) state;

  /// Constructor.
  CreateHabitController({
    String name,
    String points,
    this.activeDays,
    this.icon = emptyIcon,
    this.color = Colors.blue,
    this.time,
    this.id,
  }) {
    nameController = TextEditingController(text: name);
    pointsController = TextEditingController(text: points);
    activeDays ??= [];
  }

  /// Changes [color] and [icon] to what user selected.
  void onChange(Color color, IconData icon) {
    this.color = color;
    this.icon = icon;
    notifyListeners();
  }

  /// Creates or updates habit.
  Future create(BuildContext context) async {
    if (formKey.currentState.validate()) {
      final habitsBloc = Provider.of<HabitsBloc>(context, listen: false);
      final currentBloc = Provider.of<CurrentBloc>(context, listen: false);
      final notificationBloc =
          Provider.of<NotificationBloc>(context, listen: false);
      final habit = Habit(
        id: id,
        // If id is not provided, new id will be genereted by [Habit].
        name: nameController.text,
        points: int.parse(pointsController.text),
        colorHex: colorToHex(color),
        iconData: iconDataToMap(icon),
        goal: Goal(
          activeDays: activeDays,
          times: 1,
          unit: 'default',
          notificationTimes: time != null ? [time] : [],
        ),
      );

      if (id != null) habitsBloc.update(habit);
      if (id == null) habitsBloc.add(habit);

      await currentBloc.updateHabits();
      await notificationBloc.update();
    }
  }
}
