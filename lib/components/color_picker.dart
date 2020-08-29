import 'package:flutter/material.dart';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:habitflow/resources/strings.dart';

/// A button to allow user to pick a color.
class ColorPicker extends StatefulWidget {
  /// Constructs.
  const ColorPicker({
    @required this.color,
    @required this.onChange,
  });

  /// Initial color.
  final Color color;

  /// Function to run when user selects a color.
  final Function(Color) onChange;

  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  Color _color;

  /// Changes [_color] to [color] selected by user and runs [widget.onChange].
  void _onChange(Color color) {
    setState(() => _color = color);
    widget.onChange(color);
  }

  /// Displays a color picker dialog.
  void _showPicker(BuildContext context) {
    showDialog<AlertDialog>(
      context: context,
      child: AlertDialog(
        title: Text(pickColor),
        content: BlockPicker(
          pickerColor: _color,
          onColorChanged: _onChange,
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
    return ClipOval(
      child: Material(
        color: _color,
        child: InkWell(
          onTap: () => _showPicker(context),
          child: const SizedBox(
            width: 24,
            height: 24,
          ),
        ),
      ),
    );
  }
}
