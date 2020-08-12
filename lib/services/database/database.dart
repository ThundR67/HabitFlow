/// This service allows any service to open connection to a database.
import 'dart:async';
import 'package:hive/hive.dart';

/// Allow connection to database.
///
/// Is singleton hence there will ever only be one instance.
/// This prevents multiple connections to db.
class DB {
  DB._();

  /// A single public instance of DB.
  static DB get instance => _sigleton;
  static final DB _sigleton = DB._();

  /// Creates connection to DB with [name].
  Future<Box<T>> open<T>(String name) async {
    if (Hive.isBoxOpen(name)) return Hive.box(name);
    return Hive.openBox<T>(name);
  }
}
