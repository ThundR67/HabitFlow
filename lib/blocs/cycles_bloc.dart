import 'package:flutter/material.dart';

import 'package:logger/logger.dart';

import 'package:habitflow/helpers/logger.dart';
import 'package:habitflow/models/cycle.dart';
import 'package:habitflow/services/cycles/cycles.dart';

/// Bloc to manage user's previous cycles.
class CyclesBloc extends ChangeNotifier {
  /// All the cycles.
  List<Cycle> cycles;
  final CyclesDAO _dao = CyclesDAO();
  final Logger _log = logger('Cycles Bloc');

  /// Constructs.
  CyclesBloc() {
    update();
  }

  /// Updates [cycles].
  Future update() async {
    cycles = await _dao.all();
    _log.i('Loaded all previous cycles');
    for (final cycle in cycles) {
      _log.d('${cycle.start} : ${cycle.end}');
    }
    notifyListeners();
  }
}
