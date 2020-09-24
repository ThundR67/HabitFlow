import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:flutter_iconpicker/flutter_iconpicker.dart';

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
      iconPickerShape: Theme.of(context).dialogTheme.shape,
      iconPackMode: IconPack.materialOutline,
    );
    setState(() => _icon = icon ?? emptyIcon);
    widget.onChange(_color, icon);
  }

  /// Displays a color picker dialog and changes [_color].
  void _pickColor() {
    showDialog<AlertDialog>(
      context: context,
      child: AlertDialog(
        title: Text(pickColor),
        content: BlockPicker(
          pickerColor: _color,
          onColorChanged: (Color color) {
            setState(() => _color = color);
            widget.onChange(_color, _icon);
          },
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(submit),
          ),
        ],
      ),
    );
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
            _PickerCard(
              onTap: _pickIcon,
              child: Icon(
                _icon,
                color: _color,
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
            _PickerCard(
              onTap: _pickColor,
              child: ClipOval(
                child: Material(
                  color: _color,
                  child: const SizedBox(
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PickerCard extends StatelessWidget {
  const _PickerCard({@required this.child, this.onTap});

  final Widget child;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    const BorderRadius _radius = BorderRadius.all(
      Radius.circular(100),
    );

    return Card(
      shape: const RoundedRectangleBorder(borderRadius: _radius),
      child: InkWell(
        onTap: onTap,
        borderRadius: _radius,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: child,
        ),
      ),
    );
  }
}
