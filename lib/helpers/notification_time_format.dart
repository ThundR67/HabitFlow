import 'package:easy_localization/easy_localization.dart';

//// Formatter to format dates.
final DateFormat formatter = DateFormat('HH-mm');

/// Formates a [DateTime] into [String].
String formatNotificationTime(DateTime date) => formatter.format(date);

/// Parses [String] into [Datetime].
DateTime parseNotificationTime(String str) => formatter.parse(str);
