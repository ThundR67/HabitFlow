import 'package:flutter/material.dart';

import 'package:flutter_iconpicker/flutter_iconpicker.dart';

import 'package:habitflow/components/color_picker.dart';
import 'package:habitflow/components/neu_card.dart';
import 'package:habitflow/resources/icons.dart';
import 'package:habitflow/resources/strings.dart';

/// A row to show display color and icon picker.
class Pickers extends StatefulWidget {
  /// Constructs
  const Pickers({
    @required this.color,
    @required this.icon,
    @required this.onChange,
  });

  /// Initial color.
  final Color color;

  /// Initial icon.
  final IconData icon;

  /// Function to call when icon or color changes.
  final Function(Color, IconData) onChange;

  @override
  _PickersState createState() => _PickersState();
}

class _PickersState extends State<Pickers> {
  Color _color;
  IconData _icon;

  /// Changes [_color] to one selected by user.
  void _onColorChange(Color color) {
    setState(() => _color = color);
    widget.onChange(_color, _icon);
  }

  /// Displays dialog which allows to pick an icon and changes [_icon].
  Future<void> _pickIcon() async {
    final IconData icon = await FlutterIconPicker.showIconPicker(
      context,
      iconPackMode: IconPack.materialOutline,
    );
    setState(() => _icon = icon ?? emptyIcon);
    widget.onChange(_color, icon);
  }

  @override
  Widget build(BuildContext context) {
    _color ??= widget.color;
    _icon ??= widget.icon;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                icon,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            NeuCard(
              depth: 1.5,
              radius: 100.0,
              child: IconButton(
                onPressed: _pickIcon,
                color: _color,
                icon: Icon(_icon),
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
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            NeuCard(
              depth: 1.5,
              radius: 100.0,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ColorPicker(
                  onChange: _onColorChange,
                  color: _color,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
