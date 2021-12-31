import 'package:exp/model/ExpenseEntry.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

import 'DateKey.dart';

class ExpenseList extends ChangeNotifier {
  static final ExpenseList _list = ExpenseList._internal();
  late Map<DateKey, List<ExpenseEntry>> entries;
  late double total;
  late double thisMonth;

  factory ExpenseList() {
    return _list;
  }

  ExpenseList._internal() {
    fill();
    computeTotal();
    notifyListeners();
  }

  // TODO load from database
  void fill() {
    entries = {
      DateKey(2021, 12): [
        ExpenseEntry("migros", 53.20, DateTime(2021, 12, 27)),
        ExpenseEntry("ya pometta", 15.00, DateTime(2021, 12, 30)),
        ExpenseEntry("denner", 22.00, DateTime(2021, 12, 27)),
        ExpenseEntry("takinoa", 6.00, DateTime(2021, 12, 28)),
        ExpenseEntry("random", 7.00, DateTime(2021, 12, 25)),
      ],
      DateKey(2021, 11): [
        ExpenseEntry("migros", 44.90, DateTime(2021, 11, 30)),
      ],
    };
    sort();
  }

  void sort() {
    for (DateKey key in entries.keys) {
      entries[key]!.sort(compareEntries);
    }
  }

  void sortList(DateKey key) {
    entries[key]?.sort(compareEntries);
  }

  int compareEntries(ExpenseEntry e1, ExpenseEntry e2) =>
      e1.date.isBefore(e2.date) ? 1 : -1;

  int compareKeys(DateKey k1, DateKey k2) =>
      DateTime(k1.year, k1.month).isBefore(DateTime(k2.year, k2.month))
          ? 1
          : -1;

  // TODO
  void writeToDB() {}

  void add(ExpenseEntry entry) {
    final key = DateKey(entry.date.year, entry.date.month);
    entries.putIfAbsent(key, () => []);
    entries[key]!.add(entry);
    total += entry.amount;
    sortList(key);
    writeToDB();
    notifyListeners();
  }

  void remove(ExpenseEntry entry) {
    final key = DateKey(entry.date.year, entry.date.month);
    final res = entries[key]?.remove(entry);
    if (res != null) {
      total -= entry.amount;
    }
    writeToDB();
    notifyListeners();
  }

  void computeTotal() {
    total = 0;
    List<DateKey> sortedKeys = entries.keys.toList();
    sortedKeys.sort(compareKeys);
    for (int i = 0; i < sortedKeys.length; ++i) {
      final expenses = entries[sortedKeys[i]];
      for (ExpenseEntry expense in expenses!) {
        total += expense.amount;
      }
    }
  }

  List<ExpenseEntry> get allEntries {
    List<ExpenseEntry> sortedEntries = [];
    List<DateKey> sortedKeys = entries.keys.toList();
    sortedKeys.sort(compareKeys);
    for (int i = 0; i < sortedKeys.length; ++i) {
      sortedEntries.addAll(entries[sortedKeys[i]]!);
    }
    return sortedEntries;
  }

  double totalFor(DateKey key) {
    double partial = 0;
    if (entries[key] != null) {
      for (ExpenseEntry entry in entries[key]!) {
        partial += entry.amount;
      }
    }
    return partial;
  }
}
