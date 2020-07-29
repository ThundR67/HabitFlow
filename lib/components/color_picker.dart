import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

/// A widget which allows user to pick colors.
class ColorPickerButton extends StatefulWidget {
  /// Constructs.
  const ColorPickerButton(
    this._onChange,
    this._currentColor, {
    Key key,
  }) : super(key: key);

  final Color _currentColor;
  final Function(Color) _onChange;

  @override
  _ColorPickerButtonState createState() => _ColorPickerButtonState(
        _onChange,
        _currentColor,
      );
}

class _ColorPickerButtonState extends State<ColorPickerButton> {
  _ColorPickerButtonState(this._onChange, this._currentColor);

  Color _currentColor;
  final Function(Color) _onChange;

  void _onColorSelected(Color color) {
    setState(() {
      _currentColor = color;
      _onChange(color);
    });
  }

  /// Displays color picker.
  void _showColorPickerButton(BuildContext context) {
    showDialog<AlertDialog>(
      context: context,
      child: AlertDialog(
        title: Text(tr('pickColor')),
        content: SingleChildScrollView(
          child: MaterialPicker(
            pickerColor: _currentColor,
            onColorChanged: _onColorSelected,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(tr('submit')),
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
          color: _currentColor, // button color
          child: InkWell(
            child: const SizedBox(
              width: 24,
              height: 24,
            ),
            onTap: () => _showColorPickerButton(context),
          ),
        ),
      ),
    );
  }
}
