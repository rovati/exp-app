import 'package:exp/model/ExpenseEntry.dart';

import 'package:flutter/material.dart';

class ExpenseList extends ChangeNotifier {
  static final ExpenseList _list = ExpenseList._internal();
  late List<ExpenseEntry> entries;

  factory ExpenseList() {
    return _list;
  }

  ExpenseList._internal() {
    fill();
    notifyListeners();
  }

  // TODO load from database
  void fill() {
    entries = [
      ExpenseEntry("migros", 53.20, DateTime(2021, 12, 27)),
      ExpenseEntry("ya pometta", 15.00, DateTime(2021, 12, 30)),
      ExpenseEntry("denner", 22.00, DateTime(2021, 12, 27)),
      ExpenseEntry("takinoa", 6.00, DateTime(2021, 12, 28)),
      ExpenseEntry("random", 7.00, DateTime(2021, 12, 25)),
    ];
    sort();
  }

  void sort() {
    entries.sort((e1, e2) => e1.date.isBefore(e2.date) ? 1 : -1);
  }

  // TODO
  void writeToDB() {}

  void add(ExpenseEntry entry) {
    entries.add(entry);
    sort();
    writeToDB();
    notifyListeners();
  }

  void remove(ExpenseEntry entry) {
    entries.remove(entry);
    writeToDB();
    notifyListeners();
  }

  void removeAt(int idx) {
    entries.removeAt(idx);
    writeToDB();
    notifyListeners();
  }
}
