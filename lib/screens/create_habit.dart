import 'package:flutter/material.dart';

import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:habitflow/blocs/notification_bloc.dart';
import 'package:provider/provider.dart';

import 'package:habitflow/blocs/current_bloc.dart';
import 'package:habitflow/blocs/habits_bloc.dart';
import 'package:habitflow/components/notification_time_selector.dart';
import 'package:habitflow/components/pickers.dart';
import 'package:habitflow/components/weekdays_picker.dart';
import 'package:habitflow/helpers/colors.dart';
import 'package:habitflow/helpers/validators.dart';
import 'package:habitflow/models/goal.dart';
import 'package:habitflow/models/habit.dart';
import 'package:habitflow/resources/icons.dart';
import 'package:habitflow/resources/strings.dart';
import 'package:tinycolor/tinycolor.dart';

/// A screen which allows user to create a habit.
class CreateHabit extends StatefulWidget {
  /// Constructs
  const CreateHabit();

  @override
  _CreateHabitState createState() => _CreateHabitState();
}

class _CreateHabitState extends State<CreateHabit> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _pointsController = TextEditingController();
  List<int> _activeDays = [];
  IconData _icon = emptyIcon;
  Color _color;
  HabitsBloc _bloc;
  CurrentBloc _currentBloc;
  NotificationBloc _notificationBloc;
  TimeOfDay _time;

  /// Changes [_color] and [_icon] to what user selected.
  void _onChange(Color color, IconData icon) {
    setState(() {
      _color = color;
      _icon = icon;
    });
  }

  /// Creates the habit.
  void _create() {
    if (_formKey.currentState.validate()) {
      _bloc
          .add(
        Habit(
          name: _nameController.text,
          points: int.parse(_pointsController.text),
          colorHex: colorToHex(_color),
          iconData: iconDataToMap(_icon),
          goal: Goal(
            activeDays: _activeDays,
            times: 1,
            unit: 'default',
            notificationTimes: _time != null ? [_time] : [],
          ),
        ),
      )
          .whenComplete(() {
        _currentBloc.updateHabits();
        _notificationBloc.update();
      });

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    _bloc = Provider.of<HabitsBloc>(context);
    _currentBloc = Provider.of<CurrentBloc>(context, listen: false);
    _notificationBloc = Provider.of<NotificationBloc>(context, listen: false);
    _color ??= Theme.of(context).accentColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(createHabitTitle),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Pickers(
                      color: _color,
                      icon: _icon,
                      onChange: _onChange,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Divider(),
                    ),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: habitName,
                        suffixIcon: const Icon(nameIcon),
                      ),
                      validator: validateStr,
                    ),
                    const SizedBox(height: 24.0),
                    TextFormField(
                      controller: _pointsController,
                      decoration: InputDecoration(
                        labelText: rewardPoints,
                        suffixIcon: const Icon(rewardIcon),
                      ),
                      validator: validatePosInt,
                    ),
                    const SizedBox(height: 16.0),
                    WeekdaysPicker(
                      onChange: (days) => _activeDays = days,
                      color: _color,
                    ),
                    const SizedBox(height: 16.0),
                    NotificationTimeSelector(
                      onChange: (TimeOfDay time) => _time = time,
                      color: _color,
                    ),
                    const SizedBox(height: 16.0),
                    RaisedButton.icon(
                      onPressed: _create,
                      icon: const Icon(addIcon),
                      color: _color,
                      label: Text(submit),
                      textColor: TinyColor(_color).isLight()
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
