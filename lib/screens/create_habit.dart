import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:habitflow/blocs/habits_bloc.dart';
import 'package:habitflow/components/weekdays_picker.dart';
import 'package:habitflow/models/habit.dart';

import 'package:provider/provider.dart';

import 'package:habitflow/components/neu_text_field.dart';
import 'package:habitflow/components/pickers.dart';

/// A screen which allows user to create a reward.
class CreateHabit extends StatefulWidget {
  /// Constructs
  const CreateHabit({Key key}) : super(key: key);

  @override
  _CreateHabitState createState() => _CreateHabitState();
}

class _CreateHabitState extends State<CreateHabit> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _pointsController = TextEditingController();
  List<int> _activeDays = <int>[];
  IconData _icon = Icons.accessibility;
  Color _color = Colors.redAccent;
  HabitsBloc _bloc;

  /// Updates [_activeDays].
  void _onWeekdaysChange(List<int> days) => _activeDays = days;

  /// Changes [_color] and [_icon] to what user selected.
  void _onPick(Color color, IconData icon) {
    setState(() {
      _color = color;
      _icon = icon;
    });
  }

  /// Creates the reward.
  void _create() {
    if (_formKey.currentState.validate()) {
      _bloc.add(
        Habit(
          name: _nameController.text,
          points: int.parse(_pointsController.text),
          colorHex: '#${_color.value.toRadixString(16)}',
          iconData: iconDataToMap(_icon),
          activeDays: _activeDays,
        ),
      );
      Navigator.pop(context);
    }
  }

  /// Validates reward points.
  String _validatePoints(String value) {
    if (value.isEmpty || int.tryParse(value) == null) {
      return 'Please enter valid integer';
    } else if (int.parse(value) <= 0) {
      return 'Please enter valid posetive integer';
    }
    return null;
  }

  /// Validates reward name.
  String _validateName(String value) {
    if (value.isEmpty) {
      return 'Please enter valid name';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    _bloc = Provider.of<HabitsBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create A Habit'),
        centerTitle: true,
        backgroundColor: _color,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Pickers(_color, _icon, _onPick),
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Divider(),
                      ),
                      NeuInputTextField(
                        controller: _nameController,
                        text: 'Reward Name',
                        validate: _validateName,
                      ),
                      const SizedBox(height: 24.0),
                      NeuInputTextField(
                        controller: _pointsController,
                        text: 'Reward Points',
                        validate: _validatePoints,
                      ),
                      const SizedBox(height: 16.0),
                      WeekdaysPicker(_onWeekdaysChange),
                      const SizedBox(height: 16.0),
                      RaisedButton(
                        onPressed: _create,
                        child: const Text('Done'),
                        elevation: 4,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
