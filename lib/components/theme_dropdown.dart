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

  final Map<String, String> _themes = {
    strings.light: light,
    strings.dark: dark,
    strings.system: system,
  };

  final Map<String, ThemeMode> _themeModes = {
    strings.light: ThemeMode.light,
    strings.dark: ThemeMode.dark,
    strings.system: ThemeMode.system,
  };

  /// Changes [_value] to [value] and saves the theme if [save].
  void _onChange(String value, [bool save = true]) {
    Provider.of<AdBloc>(context, listen: false).interstitial();
    setState(() => _value = value);
    if (save) {
      final ThemeBloc bloc = Provider.of<ThemeBloc>(context, listen: false);
      bloc.set(_themes[value]);
    }
  }

  @override
  Widget build(BuildContext context) {
    /// Loads [_value] with current theme if its null.
    if (_value == null) {
      /// Sets [_value] to current theme.
      final ThemeBloc bloc = Provider.of<ThemeBloc>(context);
      _themes.forEach((key, value) {
        if (_themeModes[value] == bloc.current) _value = key;
        setState(() {});
      });
    }

    return DropdownButton<String>(
      items: _themes.keys.map(
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
