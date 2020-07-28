import 'package:intl/intl.dart';

/// Creates a list of dates from [start] to [end].
List<DateTime> getDates(DateTime start, DateTime end) {
  final List<DateTime> output = <DateTime>[];
  final int difference = end.difference(start).inDays;
  for (int i = 0; i <= difference; i++) {
    output.add(start.add(Duration(days: i)));
  }
  return output;
}

//// Formatter to format dates.
final DateFormat formatter = DateFormat('yyyy-MM-dd');

/// Formates a [DateTime] into [String].
String formatDate(DateTime date) => formatter.format(date);

/// Parses [String] into [Datetime].
DateTime parseDate(String str) => formatter.parse(str);
