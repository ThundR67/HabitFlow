import 'package:flutter/material.dart';

import 'package:habitflow/models/cycle.dart';
import 'package:habitflow/models/dates.dart';
import 'package:habitflow/models/day.dart';
import 'package:habitflow/services/cycles/cycles.dart';
import 'package:habitflow/services/days/dao.dart';

/// Bloc to manage cycles
class Cycles extends ChangeNotifier {
  /// Constructs.
  Cycles() {
    _dao.clear().whenComplete(_update);
  }

  final CyclesDAO _dao = CyclesDAO();
  final DaysDAO _daysDAO = DaysDAO();

  /// All the cycles.
  List<Cycle> cycles = <Cycle>[];

  /// Updates [cycle].
  Future<void> _update() async {
    cycles = await _dao.all();
    notifyListeners();
  }

  /// Returns whether a cycle is currently running.
  bool isRunning() => parseDate(cycles[0].end).isAfter(DateTime.now());

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
    final List<DateTime> dates = getDates(
      parseDate(cycles[0].start),
      parseDate(cycles[0].start),
    );
    final Cycle cycle = cycles[0];
    cycle.review = review;
    for (final DateTime date in dates) {
      cycle.days.add(await _daysDAO.getFromDate(date));
    }
    await _dao.update(cycle);
    await _update();
  }
}
