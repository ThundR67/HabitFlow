import 'package:flutter/material.dart';
import 'package:habitflow/helpers/date_format.dart';

import 'package:habitflow/models/cycle.dart';
import 'package:habitflow/services/cycles/cycles.dart';

/// Bloc to manage user's previous cycles.
class CyclesBloc extends ChangeNotifier {
  /// Constructs.
  CyclesBloc() {
    _dao
        .add(Cycle(
          start: formatDate(DateTime.now().subtract(Duration(days: 20))),
          end: formatDate(DateTime.now().subtract(Duration(days: 5))),
          days: {},
        ))
        .whenComplete(_update);
  }

  final CyclesDAO _dao = CyclesDAO();

  /// All the cycles.
  List<Cycle> cycles;

  /// Updates [cycles].
  Future<void> _update() async {
    cycles = await _dao.all();
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _dao.close();
  }
}
