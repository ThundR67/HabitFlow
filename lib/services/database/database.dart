/// This service allows any service to open connection to a database.

export 'db_legacy.dart';
import 'dart:async';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

/// Opens database with [name].
Future<Box> openDatabase(String name) async {
  final path = await getApplicationDocumentsDirectory();
  Hive.init(path.path);
  return Hive.openBox(name);
}
