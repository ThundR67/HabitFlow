import 'package:easy_localization/easy_localization.dart';

//// Formatter to format dates.
final DateFormat formatter = DateFormat('yyyy-MM-dd');

/// Formates a [DateTime] into [String].
String formatDate(DateTime date) => formatter.format(date);

/// Parses [String] into [Datetime].
DateTime parseDate(String str) => formatter.parse(str);
