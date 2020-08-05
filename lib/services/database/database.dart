/// This service allows any service to open connection to a database.

import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast_web/sembast_web.dart';

/// Allow connection to database.
///
/// Is singleton hence there will ever only be one instance.
/// This prevents multiple connections to db.
class DB {
  DB._();

  /// A single public instance of DB.
  static DB get instance => _sigleton;
  static final DB _sigleton = DB._();

  // ignore: always_specify_types
  final Map<String, Completer<Database>> _dbOpenCompleters = {};

  /// Creates connection to DB with [name].
  Future<Database> database(String name) async {
    if (_dbOpenCompleters[name] == null) {
      _dbOpenCompleters[name] = Completer<Database>();
      await _openDatabase(name);
    }
    return _dbOpenCompleters[name].future;
  }

  /// Opens connection to DB with [name].
  Future<void> _openDatabase(String name) async {
    Database database;
    if (kIsWeb) {
      database = await databaseFactoryWeb.openDatabase(name);
    } else {
      final Directory appDocumentDir = await getApplicationDocumentsDirectory();
      final String dbPath = appDocumentDir.path + '$name.db';
      database = await databaseFactoryIo.openDatabase(dbPath);
    }
    _dbOpenCompleters[name].complete(database);
  }
}
