/// This service allows any service to open connection to a database.

export 'db_legacy.dart';
import 'dart:async';
import 'dart:io';
import 'package:habitflow/models/goal.dart';
import 'package:habitflow/models/habit.dart';
import 'package:habitflow/models/reward.dart';
import 'package:habitflow/models/time_of_day.g.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

/// Allow connection to database.
///
/// Is singleton hence there will ever only be one instance.
/// This prevents multiple connections to db.
class DB2 {
  DB2._();

  /// A single public instance of DB.
  static DB2 get instance => _sigleton;
  static final DB2 _sigleton = DB2._();
  bool _isInited = false;

  /// Initialized hive.
  Future<void> _init() async {
    final Directory dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    Hive.registerAdapter(RewardAdapter());
    Hive.registerAdapter(HabitAdapter());
    Hive.registerAdapter(GoalAdapter());
    Hive.registerAdapter(TimeAdapter());
    _isInited = true;
  }

  /// Creates connection to DB with [name].
  Future<Box<T>> open<T>(String name) async {
    if (!_isInited) await _init();
    if (Hive.isBoxOpen(name)) return Hive.box(name);
    return Hive.openBox<T>(name);
  }
}
