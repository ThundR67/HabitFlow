import 'package:flutter/material.dart';

/// A widget to show reward points with the icon.
class RewardPoints extends StatelessWidget {
  /// Constructs
  const RewardPoints(
    this._points, {
    Key key,
    this.size = 16.0,
  }) : super(key: key);

  final int _points;

  /// Size of the widget.
  final double size;

  @override
  Widget build(BuildContext context) {
    if (_points == -1) {
      return const CircularProgressIndicator();
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          _points.toString(),
          style: TextStyle(
            fontSize: size,
          ),
        ),
        const Icon(
          Icons.star,
          color: Colors.yellow,
        ),
      ],
    );
  }
}
