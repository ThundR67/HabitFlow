import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:habitflow/components/neu_card.dart';
import 'package:habitflow/components/color_picker.dart';

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
  final Icon _icon;
  final Function(Color, Icon) _onPick;

  @override
  _PickersState createState() => _PickersState(_color, _icon, _onPick);
}

class _PickersState extends State<Pickers> {
  _PickersState(this._color, this._icon, this._onPick);

  Color _color;
  Icon _icon;
  final Function(Color, Icon) _onPick;

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
    _icon = Icon(icon);
    setState(() {});
    _onPick(_color, _icon);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Icon',
                  style: TextStyle(
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
                  icon: _icon != null
                      ? Icon(_icon.icon)
                      : const Icon(Icons.accessibility),
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Color',
                  style: TextStyle(
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
