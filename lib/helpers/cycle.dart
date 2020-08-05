import 'package:habitflow/helpers/date_format.dart';
import 'package:habitflow/models/cycle.dart';

/// Returns a new cycle
Cycle newCycle() {
  final DateTime start = DateTime.now();
  final DateTime end = start.add(const Duration(days: 14));
  return Cycle(start: formatDate(start), end: formatDate(end));
}
