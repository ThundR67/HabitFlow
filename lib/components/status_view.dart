import 'package:flutter/material.dart';
import 'package:habitflow/models/status.dart';

/// A widget to indicate the status of the habit.
class StatusView extends StatelessWidget {
  //// Constructs.
  const StatusView(this._status, {Key key}) : super(key: key);

  final Status _status;

  /// Returns color based on [_status].
  Color _color() {
    switch (_status) {
      case Status.done:
        return Colors.greenAccent;
      case Status.skipped:
        return Colors.blueAccent;
      case Status.failed:
        return Colors.redAccent;
      default:
        return Colors.black;
    }
  }

  // Returns icon based on [_status].
  IconData _icon() {
    switch (_status) {
      case Status.done:
        return Icons.done;
      case Status.skipped:
        return Icons.repeat;
      case Status.failed:
        return Icons.stop;
      default:
        return Icons.ac_unit;
    }
  }

  // Returns text based on [_status].
  String _text() {
    switch (_status) {
      case Status.done:
        return 'DONE';
      case Status.skipped:
        return 'SKIPPED';
      case Status.failed:
        return 'FAILED';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Icon(
          _icon(),
          color: _color(),
        ),
        Text(
          _text(),
          style: TextStyle(
            color: _color(),
          ),
        ),
      ],
    );
  }
}
