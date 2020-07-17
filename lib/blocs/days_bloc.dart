import 'package:flutter/material.dart';
import 'package:habitflow/models/dates.dart';

import 'package:habitflow/models/day.dart';
import 'package:habitflow/services/days/days.dart';

/// A bloc to manage days information.
class DaysBloc extends ChangeNotifier {
  /// Causes update as constructed.
  DaysBloc() {
    /// TODO remove clear
    _dao.clear().whenComplete(_update);
  }

  final DaysDAO _dao = DaysDAO();

  /// All days stored in db.
  List<Day> days = <Day>[];

  /// Updates [days].
  void _update() {
    _dao.all().then((List<Day> value) {
      days = value;
      notifyListeners();
    });
  }

  /// Fills all the days that werent recorded.
  /// Wont fill in if last day was more than 15 days old.
  void _fill() {
    final DateTime lastDate = Day.parse(days[0].date);
    final int difference = DateTime.now().difference(lastDate).inDays;
    if (difference > 15) {
      return;
    }
    getDates(DateTime.now(), lastDate).forEach((DateTime date) { 
      Day day = Day(date: Day.format(date),)
    });
  }
}
