import 'package:flutter/material.dart';
import 'package:habitflow/helpers/ads.dart';

import 'package:provider/provider.dart';

import 'package:habitflow/blocs/theme_bloc.dart';
import 'package:habitflow/resources/strings.dart' as strings;

/// Dropdown widget to allow user to change themes.
class ThemeDropDown extends StatefulWidget {
  /// Constructs.
  const ThemeDropDown();

  @override
  _ThemeDropDownState createState() => _ThemeDropDownState();
}

class _ThemeDropDownState extends State<ThemeDropDown> {
  String _value;

  final Map<String, String> themeNames = {
    strings.light: light,
    strings.dark: dark,
    strings.system: system,
  };

  /// Changes states when user selects a value.
  void _onChange(String value, [bool save = true]) {
    showInterstitialAd();
    final ThemeBloc bloc = Provider.of<ThemeBloc>(context, listen: false);
    setState(() => _value = value);
    if (save) {
      bloc.set(themeNames[value]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeBloc bloc = Provider.of<ThemeBloc>(context);
    themeNames.forEach((key, value) {
      if (value == bloc.current) _value = key;
    });

    return DropdownButton<String>(
      items: themeNames.keys.map(
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
