import 'package:flutter/material.dart';
import 'package:habitflow/blocs/theme_bloc.dart';
import 'package:habitflow/resources/strings.dart';
import 'package:provider/provider.dart';

/// Dropdown widget to allow user to change themes.
class ThemeDropDown extends StatefulWidget {
  /// Constructs.
  const ThemeDropDown();

  @override
  _ThemeDropDownState createState() => _ThemeDropDownState();
}

class _ThemeDropDownState extends State<ThemeDropDown> {
  final List<String> _values = [system, light, dark];
  String _value;

  /// Changes states when user selects a value.
  void _onChange(String value, [bool save = true]) {
    final ThemeBloc bloc = Provider.of<ThemeBloc>(context, listen: false);
    setState(() => _value = value);
    if (save) {
      if (value == system) bloc.set(ThemeMode.system);
      if (value == light) bloc.set(ThemeMode.light);
      if (value == dark) bloc.set(ThemeMode.dark);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeBloc bloc = Provider.of<ThemeBloc>(context);
    if (bloc.theme == null) return const Text('...');

    if (bloc.mode == ThemeMode.system) _value = system;
    if (bloc.mode == ThemeMode.light) _value = light;
    if (bloc.mode == ThemeMode.dark) _value = dark;

    return DropdownButton<String>(
      items: _values.map(
        (String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        },
      ).toList(),
      value: _value,
      onChanged: _onChange,
    );
  }
}
