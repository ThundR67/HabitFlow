import 'package:flutter/material.dart';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:habitflow/resources/strings.dart';

/// A widget which allows user to pick colors.
class ColorPickerButton extends StatefulWidget {
  /// Constructs.
  const ColorPickerButton({
    @required this.color,
    @required this.onChange,
  });

  /// Initial color.
  final Color color;

  /// Function to run when [color] is changed.
  final Function(Color) onChange;

  @override
  _ColorPickerButtonState createState() => _ColorPickerButtonState();
}

class _ColorPickerButtonState extends State<ColorPickerButton> {
  /// Sets [_color] with [widget.color].
  _ColorPickerButtonState() {
    _color = widget.color;
  }

  Color _color;

  void _onChange(Color color) {
    setState(() {
      _color = color;
      widget.onChange(color);
    });
  }

  /// Displays color picker.
  void _showPicker(BuildContext context) {
    showDialog<AlertDialog>(
      context: context,
      child: AlertDialog(
        title: Text(pickColor),
        content: SingleChildScrollView(
          child: MaterialPicker(
            pickerColor: _color,
            onColorChanged: _onChange,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(submit),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipOval(
        child: Material(
          color: _color, // button color
          child: InkWell(
            child: const SizedBox(
              width: 24,
              height: 24,
            ),
            onTap: () => _showPicker(context),
          ),
        ),
      ),
    );
  }
}
