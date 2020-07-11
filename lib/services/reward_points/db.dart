import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

/// Allow connection to database.
///
/// Is singleton hence there will ever only be one instance.
/// This prevents multiple connections to db.
class DB {
  DB._();

  /// A single public instance of DB.
  static DB get instance => _sigleton;
  Completer<Database> _dbOpenCompleter;
  static final DB _sigleton = DB._();

  /// A connection to DB.
  Future<Database> get database async {
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer<Database>();
      await _openDatabase();
    }
    return _dbOpenCompleter.future;
  }

  /// Opens connection to DB.
  Future<void> _openDatabase() async {
    final Directory appDocumentDir = await getApplicationDocumentsDirectory();
    final String dbPath = appDocumentDir.path + 'points.db';
    final Database database = await databaseFactoryIo.openDatabase(dbPath);
    _dbOpenCompleter.complete(database);
  }
}
