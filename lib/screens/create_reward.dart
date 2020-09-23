import 'package:flutter/material.dart';

import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:provider/provider.dart';

import 'package:habitflow/blocs/rewards_bloc.dart';
import 'package:habitflow/components/pickers.dart';
import 'package:habitflow/helpers/colors.dart';
import 'package:habitflow/helpers/validators.dart';
import 'package:habitflow/models/reward.dart';
import 'package:habitflow/resources/icons.dart';
import 'package:habitflow/resources/strings.dart';
import 'package:tinycolor/tinycolor.dart';

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
        title: Text(
          createRewardTitle,
        ),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Pickers(
                      color: _color,
                      icon: _icon,
                      onChange: _onChange,
                    ),
                    const SizedBox(height: 24.0),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: rewardName,
                        suffixIcon: const Icon(nameIcon),
                      ),
                      validator: validateStr,
                    ),
                    const SizedBox(height: 24.0),
                    TextFormField(
                      controller: _pointsController,
                      decoration: InputDecoration(
                        labelText: rewardCost,
                        suffixIcon: const Icon(rewardIcon),
                      ),
                      validator: validatePosInt,
                    ),
                    const SizedBox(height: 16.0),
                    RaisedButton.icon(
                      onPressed: _create,
                      icon: const Icon(addIcon),
                      color: _color,
                      label: Text(submit),
                      textColor: TinyColor(_color).isLight()
                          ? Colors.black
                          : Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
