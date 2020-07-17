import 'package:flutter/material.dart';

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
}
