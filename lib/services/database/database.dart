/// This service allows any service to open connection to a database.

export 'db_legacy.dart';
import 'dart:async';
import 'dart:io';
import 'package:habitflow/models/reward.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

/// Allow connection to database.
///
/// Is singleton hence there will ever only be one instance.
/// This prevents multiple connections to db.
class DB2 {
  DB2._() {
    Hive.registerAdapter(RewardAdapter());
  }

  /// A single public instance of DB.
  static DB2 get instance => _sigleton;
  static final DB2 _sigleton = DB2._();

  final Map<String, Completer> _completers = {};

  /// Creates connection to DB with [name].
  Future<Box<T>> open<T>(String name) async {
    if (_completers[name] == null) {
      _completers[name] = Completer();
      await _openDatabase<T>(name);
    }
    return Hive.box<T>(name);
  }

  /// Opens connection to DB with [name].
  Future<void> _openDatabase<T>(String name) async {
    final Directory dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    assert(!Hive.isBoxOpen(name));
    _completers[name].complete(await Hive.openBox<T>(name));
  }
}
