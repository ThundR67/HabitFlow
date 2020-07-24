import 'package:flutter/material.dart';

import 'package:habitflow/models/cycle.dart';
import 'package:habitflow/models/dates.dart';
import 'package:habitflow/models/day.dart';
import 'package:habitflow/services/cycles/cycles.dart';
import 'package:habitflow/services/days/dao.dart';

/// Bloc to manage cycles
class CyclesBloc extends ChangeNotifier {
  /// Constructs.
  CyclesBloc() {
    _dao.clear().whenComplete(_update);
  }

  final CyclesDAO _dao = CyclesDAO();
  final DaysDAO _daysDAO = DaysDAO();

  /// All the cycles.
  List<Cycle> cycles = <Cycle>[];

  /// Current cycle.
  Cycle current = Cycle(start: '00-00-00', end: '00-00-00');

  /// Updates [cycle].
  Future<void> _update() async {
    cycles = await _dao.all();
    if (!isRunning()) {
      await start();
      await _update();
    }
    current = cycles[0];
    notifyListeners();
  }

  /// Returns whether a cycle is currently running.
  bool isRunning() {
    if (cycles.isEmpty) {
      return false;
    }
    return parseDate(cycles[0].end).isAfter(DateTime.now());
  }

  /// Starts a cycle.
  Future<void> start() async {
    final DateTime start = DateTime.now();
    final Cycle cycle = Cycle(
      start: formatDate(start),
      end: formatDate(start.add(const Duration(days: 15))),
    );
    await _dao.add(cycle);
    await _update();
  }

  /// Ends a cycle.
  Future<void> end(String review) async {
    final Cycle cycle = cycles[0];
    final List<DateTime> dates = getDates(
      parseDate(cycle.start),
      parseDate(cycle.start),
    );
    cycle.review = review;

    final Map<String, Day> days = await _daysDAO.all();
    for (final DateTime date in dates) {
      cycle.days.add(days[formatDate(date)]);
    }

    await _dao.update(cycle);
    await _update();
  }
}
