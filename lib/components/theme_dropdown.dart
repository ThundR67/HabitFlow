import 'package:flutter/material.dart';
import 'package:habitflow/blocs/ad_bloc.dart';

import 'package:provider/provider.dart';

import 'package:habitflow/blocs/theme_bloc.dart';
import 'package:habitflow/resources/strings.dart' as strings;

/// Dropdown to allow user to change themes.
class ThemeDropDown extends StatefulWidget {
  /// Constructs.
  const ThemeDropDown();

  @override
  _ThemeDropDownState createState() => _ThemeDropDownState();
}

class _ThemeDropDownState extends State<ThemeDropDown> {
  String _value;

  final Map<String, String> _themeNames = {
    strings.light: light,
    strings.dark: dark,
    strings.system: system,
  };

  final Map<String, ThemeMode> _themeModes = {
    light: ThemeMode.light,
    dark: ThemeMode.dark,
    system: ThemeMode.system,
  };

  /// Changes [_value] to [value] and saves the theme if [save].
  void _onChange(String value, [bool save = true]) {
    setState(() => _value = value);
    if (save) {
      final ThemeBloc bloc = Provider.of<ThemeBloc>(context, listen: false);
      bloc.set(_themeNames[value]);
    }
  }

  @override
  Widget build(BuildContext context) {
    /// Loads [_value] with current theme if its null.
    if (_value == null) {
      for (final String key in _themeNames.keys) {
        final ThemeBloc bloc = Provider.of<ThemeBloc>(context, listen: false);
        if (_themeModes[_themeNames[key]] == bloc.current) {
          _onChange(key, false);
        }
      }
    }

    return DropdownButton<String>(
      items: _themeNames.keys.map(
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
