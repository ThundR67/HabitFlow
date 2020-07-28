import 'package:flutter/material.dart';

import 'package:habitflow/models/cycle.dart';
import 'package:habitflow/services/cycles/cycles.dart';

/// Bloc to manage cycles
class CyclesBloc extends ChangeNotifier {
  /// Constructs.
  CyclesBloc() {
    _update();
  }

  final CyclesDAO _dao = CyclesDAO();

  /// All the cycles.
  Map<String, Cycle> cycles;

  /// Updates [cycles].
  Future<void> _update() async {
    cycles = await _dao.all();
    notifyListeners();
  }
}
