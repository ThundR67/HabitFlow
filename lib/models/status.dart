import 'package:flutter/material.dart';

import 'package:habitflow/resources/icons.dart';
import 'package:habitflow/resources/strings.dart';

/// An enum to store the status of the habit.
enum Status {
  /// If habit is neither done, skipped or failed.
  unmarked,

  /// If the habit is done.
  done,

  /// If the habit is skipped.
  skipped,

  /// If the habit is failed.
  failed,
}

/// Extension to allow helper functions on status.
extension EStatus on Status {
  /// Returns color based on [this].
  Color get color {
    switch (this) {
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

  /// Returns icon based on [this].
  IconData get icon {
    switch (this) {
      case Status.done:
        return doneIcon;
      case Status.skipped:
        return skippedIcon;
      case Status.failed:
        return failedIcon;
      default:
        return emptyIcon;
    }
  }

  /// Returns text based on [this].
  String get text {
    switch (this) {
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

  /// Returns text of category based on [this].
  String get category {
    switch (this) {
      case Status.done:
        return successes;
      case Status.skipped:
        return skips;
      case Status.failed:
        return failures;
      default:
        return '';
    }
  }
}
