import 'package:flutter/material.dart';
import 'package:habitflow/helpers/cycle.dart';
import 'package:habitflow/helpers/date_format.dart';
import 'package:habitflow/helpers/days.dart';

import 'package:habitflow/models/cycle.dart';
import 'package:habitflow/models/status.dart';
import 'package:habitflow/services/current_cycle/current_cycle.dart';
import 'package:habitflow/services/cycles/cycles.dart';
import 'package:habitflow/services/habits/habits.dart';

/// Bloc to manage current cycle and statuses of habits.
class CurrentCycleBloc extends ChangeNotifier {
  /// Constructs.
  CurrentCycleBloc() {
    update();
  }

  final CurrentCycleDAO _dao = CurrentCycleDAO();
  final CyclesDAO _cyclesDAO = CyclesDAO();
  final HabitsDAO _habitsDAO = HabitsDAO();

  /// Days of cycle.
  Days _days;

  /// Current cycle.
  Cycle current;

  /// Statuses of all habits.
  Map<String, Status> statuses;

  /// Updates [statuses] and [current].
  Future<void> update() async {
    current = await _dao.get();
    if (current == null) {
      await _create();
    }

    // Fills missing days and unmarked failures.
    _days = Days(current.days);
    await _days.fill(
      parseDate(current.start),
      parseDate(current.end),
      _habitsDAO,
    );
    current.days = _days.days;

    /// Updates.
    await _dao.update(current);
    notifyListeners();
  }

  /// Creates a new cycle and updates [current].
  Future<void> _create() async {
    current = Cycle(
      start: formatDate(DateTime.now()),
      end: formatDate(DateTime.now().add(const Duration(days: 15))),
    );
    await _dao.create(current);
  }

  /// Ends a cycle, puts in previous cycles, then creates new one.
  Future<void> end() async {
    await _cyclesDAO.add(current);
    await _create();
    await update();
  }
}
