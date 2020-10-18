import 'package:flutter/material.dart';

/// A widget to showcase its child.
class Showable extends StatefulWidget {
  /// Constructs.
  const Showable(
      {this.child, this.shouldShowcase = false, @required this.description});

  /// Child to showcase.
  final Widget child;

  /// Should showcase.
  final bool shouldShowcase;

  /// Description to give about the widget.
  final String description;

  @override
  _ShowableState createState() => _ShowableState();
}

class _ShowableState extends State<Showable> {
  Future _showIntro() async {
    await Future.delayed(const Duration(milliseconds: 500));
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(widget.description),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.shouldShowcase) _showIntro();
    return widget.child;
  }
}
