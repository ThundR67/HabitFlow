/// Creates a list of dates from [start] to [end].
List<DateTime> getDates(DateTime start, DateTime end) {
  final List<DateTime> output = <DateTime>[];
  final int difference = end.difference(start).inDays;
  for (int i = 0; i <= difference; i++) {
    output.add(start.add(Duration(days: i)));
  }
  return output;
}
