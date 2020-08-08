import 'package:flutter/material.dart';
import 'package:habitflow/helpers/theme.dart';
import 'package:habitflow/resources/strings.dart';
import 'package:theme_provider/theme_provider.dart';

/// Dropdown widget to allow user to change themes.
class ThemeDropDown extends StatefulWidget {
  /// Constructs.
  const ThemeDropDown();

  @override
  _ThemeDropDownState createState() => _ThemeDropDownState();
}

class _ThemeDropDownState extends State<ThemeDropDown> {
  _ThemeDropDownState() {
    getTheme().then((value) {
      if (value == ThemeMode.system) _onChange(system);
      if (value == ThemeMode.light) _onChange(system);
      if (value == ThemeMode.dark) _onChange(system);
    });
  }

  final List<String> _values = [system, light, dark];
  String _value;

  /// Changes states when user selects a value.
  void _onChange(String value) {
    final ThemeController controller = ThemeProvider.controllerOf(context);
    setState(() => _value = value);
    if (value == system) setSystem(controller);
    if (value == light) setLight(controller);
    if (value == dark) setDark(controller);
  }

  @override
  Widget build(BuildContext context) {
    if (_value == null) return const Text('...');

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
