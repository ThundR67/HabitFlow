import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:habitflow/helpers/notification_time_format.dart';

const _daysKey = 'active_days';
const _timeKey = 'time';
const _unitKey = 'unit';
const _notificationTimesKey = 'notification_times';

/// A type to store info about habits goal.
class Goal {
  /// Constrcuts.
  Goal({this.activeDays, this.time, this.unit, this.notificationTimes});

  /// Days habit active on.
  List<int> activeDays;

  /// Time to do each day.
  int time;

  /// Unit of measurement.
  String unit;

  /// Notification time.
  List<TimeOfDay> notificationTimes;

  /// Converts map to Goal.
  Goal.fromMap(Map<String, dynamic> map) {
    final List<String> timesStr = List<String>.from(
      map[_notificationTimesKey] as Iterable,
    );

    activeDays = List<int>.from(map[_daysKey] as Iterable);
    time = int.parse(map[_timeKey].toString());
    unit = map[_unitKey].toString();
    notificationTimes = [
      for (String time in timesStr) parseNotificationTime(time)
    ];
  }

  /// Converts Goal to map.
  Map<String, dynamic> toMap() {
    return {
      _daysKey: activeDays,
      _timeKey: time,
      _unitKey: unit,
      _notificationTimesKey: [
        for (TimeOfDay time in notificationTimes) formatNotificationTime(time)
      ],
    };
  }
}
