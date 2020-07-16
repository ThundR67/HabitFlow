import 'package:flutter/material.dart';
import 'package:habitflow/components/neu_card.dart';

/// Shows a list of habits.
class HabitsList extends StatelessWidget {
  /// Constructs.
  const HabitsList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 24.0),
              NeuCard(
                child: const Padding(
                  padding: EdgeInsets.all(40.0),
                  child: Text('hey'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
