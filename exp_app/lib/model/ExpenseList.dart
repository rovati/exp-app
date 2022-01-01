import 'package:exp/model/ExpenseEntry.dart';
import 'package:exp/util/DBHelper.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

import 'DateKey.dart';

class ExpenseList extends ChangeNotifier {
  static final ExpenseList _list = ExpenseList._internal();
  late Map<DateKey, List<ExpenseEntry>> entries;
  late double total;
  late bool loaded;
  late int id;

  factory ExpenseList() {
    return _list;
  }

  ExpenseList._internal() {
    loaded = false;
    id = -1;
    total = 0.00;
    entries = {};
    notifyListeners();
  }

  // TODO modify to load from DB
  void load(int listID) async {
    id = listID;
    List<ExpenseEntry> res = await DBHelper.getExpenseEntries(listID);
    for (ExpenseEntry entry in res) {
      _silentAdd(entry);
    }
    loaded = true;
    notifyListeners();

    /* Future.delayed(const Duration(seconds: 1), () {
      id = listID;
      fill();
      computeTotal();
      loaded = true;
      notifyListeners();
    }); */
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
        ExpenseEntry("denner", 30.30, DateTime(2021, 11, 26)),
        ExpenseEntry("takinoa", 8.40, DateTime(2021, 11, 28)),
        ExpenseEntry("random", 7.10, DateTime(2021, 11, 19)),
      ],
      DateKey(2021, 10): [
        ExpenseEntry("migros", 2.10, DateTime(2021, 10, 31)),
        ExpenseEntry("bira", 11.90, DateTime(2021, 10, 31)),
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

  void writeToDB() {
    DBHelper.writeList(this);
  }

  void _silentAdd(ExpenseEntry entry) {
    final key = DateKey(entry.date.year, entry.date.month);
    entries.putIfAbsent(key, () => []);
    entries[key]!.add(entry);
    total += entry.amount;
    sortList(key);
    writeToDB();
  }

  void add(ExpenseEntry entry) {
    _silentAdd(entry);
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'entries': allEntries.map((e) => e.toJson()).toList(),
    };
  }
}
