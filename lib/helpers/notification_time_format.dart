import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';

//// Formatter to format dates.
final DateFormat formatter = DateFormat('HH-mm');

/// Formates a [TimeOfDay] into [String].
String formatNotificationTime(TimeOfDay time) {
  if (time == null) return '-';
  final List<int> list = [time.hour, time.minute];
  return list.join("-");
}

/// Parses [String] into [TimeOfDay].
TimeOfDay parseNotificationTime(String str) {
  if (str == '-') return null;
  final List<String> list = str.split('-');
  return TimeOfDay(
    hour: int.parse(list[0]),
    minute: int.parse(list[1]),
  );
}
