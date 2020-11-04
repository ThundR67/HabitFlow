import 'package:flutter/material.dart';

import 'package:hive/hive.dart';

part 'goal.g.dart';

/// A type to store info about habits goal.
@HiveType(typeId: 2)
class Goal {
  /// Constrcuts.
  Goal({this.activeDays, this.times, this.unit, this.notificationTimes});

  /// Days habit active on.
  @HiveField(0)
  List<int> activeDays;

  /// Time to do each day.
  @HiveField(1)
  int times;

  /// Unit of measurement.
  @HiveField(2)
  String unit;

  /// Notification time.
  @HiveField(3)
  List<TimeOfDay> notificationTimes;
}
