import 'package:flutter/material.dart';

import 'package:habitflow/models/cycle.dart';
import 'package:habitflow/services/cycles/cycles.dart';

/// Bloc to manage user's previous cycles.
class CyclesBloc extends ChangeNotifier {
  /// Constructs.
  CyclesBloc() {
    _dao.all().then((value) {
      cycles = value;
      notifyListeners();
    });
  }

  /// All the cycles.
  List<Cycle> cycles;
  final CyclesDAO _dao = CyclesDAO();
}
