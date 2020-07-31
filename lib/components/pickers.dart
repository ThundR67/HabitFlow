import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

import 'package:habitflow/components/color_picker.dart';
import 'package:habitflow/components/neu_card.dart';
import 'package:habitflow/resources/icons.dart';
import 'package:habitflow/resources/strings.dart';

/// A widget which allows user pick icon and color.
class Pickers extends StatefulWidget {
  /// Constructs
  const Pickers(
    this._color,
    this._icon,
    this._onPick, {
    Key key,
  }) : super(key: key);

  final Color _color;
  final IconData _icon;
  final Function(Color, IconData) _onPick;

  @override
  _PickersState createState() => _PickersState(_color, _icon, _onPick);
}

class _PickersState extends State<Pickers> {
  _PickersState(this._color, this._icon, this._onPick);

  Color _color;
  IconData _icon;
  final Function(Color, IconData) _onPick;

  /// Changes [_color] to one selected by user.
  void _onColorChange(Color color) {
    setState(() => _color = color);
    _onPick(_color, _icon);
  }

  /// Allows to pick an icon.
  Future<void> _pickIcon() async {
    final IconData icon = await FlutterIconPicker.showIconPicker(
      context,
      iconPackMode: IconPack.material,
    );
    _icon = icon;
    setState(() {});
    _onPick(_color, icon);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  icon,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              NeuCard(
                depth: 1.5,
                radius: 100.0,
                child: IconButton(
                  onPressed: _pickIcon,
                  color: _color,
                  icon: _icon != null ? Icon(_icon) : const Icon(emptyIcon),
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  color,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              NeuCard(
                depth: 1.5,
                radius: 100.0,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ColorPickerButton(
                    _onColorChange,
                    _color,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
