import 'package:flutter/material.dart';
import 'package:habitflow/models/status.dart';
import 'package:habitflow/resources/icons.dart';
import 'package:habitflow/resources/strings.dart';

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
        return doneIcon;
      case Status.skipped:
        return skippedIcon;
      case Status.failed:
        return failedIcon;
      default:
        return Icons.ac_unit;
    }
  }

  // Returns text based on [_status].
  String _text() {
    switch (_status) {
      case Status.done:
        return done;
      case Status.skipped:
        return skipped;
      case Status.failed:
        return failed;
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        ClipOval(
          child: Material(
            color: _color(), // button color
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                _icon(),
                size: 24,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          _text(),
          style: TextStyle(
            color: _color(),
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
