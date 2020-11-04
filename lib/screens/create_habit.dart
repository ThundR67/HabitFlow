import 'package:flutter/material.dart';

import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:provider/provider.dart';
import 'package:tinycolor/tinycolor.dart';

import 'package:habitflow/components/notification_time_selector.dart';
import 'package:habitflow/components/pickers.dart';
import 'package:habitflow/components/weekdays_picker.dart';
import 'package:habitflow/controllers/screens/create_habit_controller.dart';
import 'package:habitflow/helpers/colors.dart';
import 'package:habitflow/helpers/validators.dart';
import 'package:habitflow/models/habit.dart';
import 'package:habitflow/resources/icons.dart';
import 'package:habitflow/resources/strings.dart';

/// Screen to allow user to create or update an habit.
class CreateHabit extends StatelessWidget {
  /// Constructs.
  const CreateHabit({this.habit});

  /// Habit data if habit needs to be edited.
  final Habit habit;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        if (habit == null) return CreateHabitController();
        final time = habit.goal.notificationTimes;
        return CreateHabitController(
          name: habit.name,
          points: habit.points.toString(),
          time: time.isEmpty ? null : time[0],
          color: hexToColor(habit.colorHex),
          icon: mapToIconData(habit.iconData),
          activeDays: habit.goal.activeDays,
          id: habit.id,
        );
      },
      child: _CreateHabit(),
    );
  }
}

class _CreateHabit extends StatelessWidget {
  Future _onSubmit(BuildContext context) async {
    final controller =
        Provider.of<CreateHabitController>(context, listen: false);
    await controller.create(context);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<CreateHabitController>(context);

    return Scaffold(
      appBar: AppBar(title: Text(createHabitTitle)),
      body: Center(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Form(
                key: controller.formKey,
                child: Column(
                  children: <Widget>[
                    Pickers(
                      color: controller.color,
                      icon: controller.icon,
                      onChange: controller.onChange,
                    ),
                    const SizedBox(height: 24.0),
                    TextFormField(
                      controller: controller.nameController,
                      decoration: InputDecoration(
                        labelText: habitName,
                        suffixIcon: const Icon(nameIcon),
                      ),
                      validator: validateStr,
                    ),
                    const SizedBox(height: 24.0),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: controller.pointsController,
                      decoration: InputDecoration(
                        labelText: rewardPoints,
                        suffixIcon: const Icon(rewardIcon),
                      ),
                      validator: validatePosInt,
                    ),
                    const SizedBox(height: 16.0),
                    WeekdaysPicker(
                      initial: controller.activeDays,
                      onChange: (days) => controller.activeDays = days,
                      color: controller.color,
                    ),
                    const SizedBox(height: 16.0),
                    NotificationTimeSelector(
                      onChange: (TimeOfDay time) => controller.time = time,
                      color: controller.color,
                      initial: controller.time,
                    ),
                    const SizedBox(height: 16.0),
                    RaisedButton.icon(
                      onPressed: () => _onSubmit(context),
                      icon: const Icon(addIcon),
                      color: controller.color,
                      label: Text(submit),
                      textColor: TinyColor(controller.color).isLight()
                          ? Colors.black
                          : Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
