import 'package:flutter/material.dart';

import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:habitflow/helpers/colors.dart';
import 'package:habitflow/helpers/validators.dart';
import 'package:provider/provider.dart';

import 'package:habitflow/blocs/rewards_bloc.dart';
import 'package:habitflow/components/neu_text_field.dart';
import 'package:habitflow/components/pickers.dart';
import 'package:habitflow/models/reward.dart';
import 'package:habitflow/resources/behaviour.dart';
import 'package:habitflow/resources/icons.dart';
import 'package:habitflow/resources/strings.dart';

/// A screen which allows user to create a reward.
class CreateReward extends StatefulWidget {
  /// Constructs.
  const CreateReward();

  @override
  _CreateRewardState createState() => _CreateRewardState();
}

class _CreateRewardState extends State<CreateReward> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _pointsController = TextEditingController();
  IconData _icon = emptyIcon;
  Color _color;
  RewardsBloc _bloc;

  /// Changes [_color] and [_icon] to what user selected.
  void _onChange(Color color, IconData icon) {
    setState(() {
      _color = color;
      _icon = icon;
    });
  }

  /// Creates the reward.
  void _create() {
    if (_formKey.currentState.validate()) {
      _bloc.add(
        Reward(
          name: _nameController.text,
          points: int.parse(_pointsController.text),
          colorHex: colorToHex(_color),
          iconData: iconDataToMap(_icon),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    _bloc = Provider.of<RewardsBloc>(context);
    _color ??= Theme.of(context).accentColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(createRewardTitle),
        backgroundColor: _color,
      ),
      body: SafeArea(
        child: Center(
          child: ListView(
            physics: scrollPhysics,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Pickers(
                        color: _color,
                        icon: _icon,
                        onChange: _onChange,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Divider(),
                      ),
                      NeuInputTextField(
                        controller: _nameController,
                        text: rewardName,
                        validate: validateStr,
                      ),
                      const SizedBox(height: 24.0),
                      NeuInputTextField(
                        controller: _pointsController,
                        text: rewardPoints,
                        validate: validatePosInt,
                      ),
                      const SizedBox(height: 16.0),
                      RaisedButton(
                        color: _color,
                        onPressed: _create,
                        elevation: 4,
                        child: Text(
                          submit,
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
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
