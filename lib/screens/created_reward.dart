import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:habitflow/blocs/rewards_bloc.dart';
import 'package:habitflow/components/color_picker.dart';
import 'package:habitflow/components/neu_card.dart';
import 'package:habitflow/components/neu_text_field.dart';

/// A screen which allows user to create a reward.
class CreateReward extends StatefulWidget {
  /// Constructs
  const CreateReward({Key key}) : super(key: key);

  @override
  _CreateRewardState createState() => _CreateRewardState();
}

class _CreateRewardState extends State<CreateReward> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _pointsController = TextEditingController();
  Icon _icon = const Icon(Icons.accessibility);
  Color _color = Colors.redAccent;

  /// Changes [_color] to one selected by user.
  void _onColorChange(Color color) => setState(() => _color = color);

  /// Allows to pick an icon.
  Future<void> _pickIcon() async {
    final IconData icon = await FlutterIconPicker.showIconPicker(
      context,
      iconPackMode: IconPack.material,
    );
    _icon = Icon(icon);
    setState(() {});
  }

  /// Creates the reward.
  void _create(RewardsBloc bloc) {
    if (_formKey.currentState.validate()) {
      bloc.add(null);
      Navigator.pop(context);
    }
  }

  /// Validates reward points.
  String _validate(String value) {
    if (value.isEmpty || int.tryParse(value) == null) {
      return 'Please enter valid integer';
    } else if (int.parse(value) <= 0) {
      return 'Please enter valid posetive integer';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create A Reward'),
        centerTitle: true,
        backgroundColor: _color,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Row(
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
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Divider(),
                      ),
                      NeuInputTextField(
                        controller: _nameController,
                        text: 'Reward Name',
                      ),
                      const SizedBox(height: 24),
                      NeuInputTextField(
                        controller: _pointsController,
                        text: 'Reward Points Required',
                        validate: _validate,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
