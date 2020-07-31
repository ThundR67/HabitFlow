import 'package:flutter/material.dart';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';

/// A widget to allow input of text.
class NeuInputTextField extends StatelessWidget {
  /// Constructs
  const NeuInputTextField({
    this.validate,
    this.controller,
    this.text,
    Key key,
  }) : super(key: key);

  /// Validates input.
  final String Function(String) validate;

  /// Text of input decoration.
  final String text;

  /// Controller of input field.
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Neumorphic(
        style: NeumorphicStyle(
          boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.circular(100.0),
          ),
          depth: -2,
          intensity: 1,
          color: Colors.grey[850],
          shadowDarkColorEmboss: Colors.grey[900],
          shadowLightColorEmboss: Colors.grey[800], //customize color here
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              labelText: text,
            ),
            validator: validate,
          ),
        ),
      ),
    );
  }
}
