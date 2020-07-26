import 'package:flutter/material.dart';

import 'package:habitflow/models/cycle.dart';
import 'package:habitflow/services/cycles/cycles.dart';

/// Bloc to manage cycles
class CyclesBloc extends ChangeNotifier {
  /// Constructs.
  CyclesBloc() {
    _dao.clear().whenComplete(_update);
  }

  final CyclesDAO _dao = CyclesDAO();

  /// All the cycles.
  Map<String, Cycle> cycles = <String, Cycle>{};

  /// Updates [cycles].
  Future<void> _update() async {
    cycles = await _dao.all();
    notifyListeners();
  }
}
