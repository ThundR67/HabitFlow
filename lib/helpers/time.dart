import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

final DateFormat _dateFormatter = DateFormat('yyyy-MM-dd');
final DateFormat _timeFormatter = DateFormat('HH-mm');

/// Extension to allow basic functions used on [DateTime] used app-wide.
extension EDateTime on DateTime {
  /// Converts [this] to [String].
  String format() => _dateFormatter.format(this);
}

/// Extension to allow basic functions used on [TimeOfDay] used app-wide.
extension ETimeOfDay on DateTime {
  /// Converts [this] to [String].
  String str() => _timeFormatter.format(this);
}

/// Extension to allow basic functions used on [String] used app-wide.
extension EString on String {
  /// Converts [this] to [Datetime].
  DateTime date() => _dateFormatter.parse(this);

  /// Converts [this] to [TimeOfDay]
  TimeOfDay timeOfDay() {
    final DateTime date = _timeFormatter.parse(this);
    return TimeOfDay(hour: date.hour, minute: date.minute);
  }
}
