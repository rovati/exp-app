import 'package:exp/model/expense_entry.dart';
import 'package:exp/util/constant/json_keys.dart';
import 'package:exp/util/db_helper.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

import 'date_key.dart';

/// Singleton model for a list of expenses. When modified, it notifies the observing
/// widget.
/// When an ExpenseScreen is opened, the ExpenseList loads the corresponding
/// list from the database.
class ExpenseList extends ChangeNotifier {
  static final ExpenseList _list = ExpenseList._internal();
  /* NOTE entries are sorted by year-month so that to have an easier way later
   when dealing with various monthly summaries */
  late Map<DateKey, List<ExpenseEntry>> entries;
  late double total;
  late bool loaded;
  late int id;

  factory ExpenseList() {
    return _list;
  }

  /// Set default values, indicating the entries haven't been loaded yet.
  ExpenseList._internal() {
    loaded = false;
    id = -1;
    total = 0.00;
    entries = {};
    notifyListeners();
  }

  /// Async loading of the entries from the local database. Listeners are
  /// notified only once the loading is completed.
  void load(int listID) async {
    id = listID;
    List<ExpenseEntry> res = await DBHelper.getExpenseEntries(listID);
    for (ExpenseEntry entry in res) {
      _silentAdd(entry);
    }
    loaded = true;
    notifyListeners();
  }

  /// Adds an entry to the entries map, notifies listeners.
  void add(ExpenseEntry entry) {
    _silentAdd(entry);
    notifyListeners();
  }

  /// Removes the entry from the entries map, notifies listeners.
  void remove(ExpenseEntry entry) {
    final key = DateKey(entry.date.year, entry.date.month);
    final res = entries[key]?.remove(entry);
    if (res != null) {
      total -= entry.amount;
    }
    _writeToDB();
    notifyListeners();
  }

  /// List of all entries, sorted by descending date
  List<ExpenseEntry> get allEntries {
    List<ExpenseEntry> sortedEntries = [];
    List<DateKey> sortedKeys = entries.keys.toList();
    sortedKeys.sort(_compareKeys);
    for (int i = 0; i < sortedKeys.length; ++i) {
      sortedEntries.addAll(entries[sortedKeys[i]]!);
    }
    return sortedEntries;
  }

  /// Returns the total expense amount for the given date key.
  double totalFor(DateKey key) {
    double partial = 0;
    if (entries[key] != null) {
      for (ExpenseEntry entry in entries[key]!) {
        partial += entry.amount;
      }
    }
    return partial;
  }

  /// Serialization for saving to local database.
  Map<String, dynamic> toJson() {
    return {
      JSONKeys.expListID: id,
      JSONKeys.expListEntries: allEntries.map((e) => e.toJson()).toList(),
    };
  }

  /// Sorts the list of entries of a given date key.
  void _sortList(DateKey key) {
    entries[key]?.sort(_compareEntries);
  }

  /// Comparator for sorting expense entries by descending date.
  int _compareEntries(ExpenseEntry e1, ExpenseEntry e2) =>
      e1.date.isBefore(e2.date) ? 1 : -1;

  /// Comparator for sorting date keys by descending date.
  int _compareKeys(DateKey k1, DateKey k2) =>
      DateTime(k1.year, k1.month).isBefore(DateTime(k2.year, k2.month))
          ? 1
          : -1;

  /// Writes this list to disk.
  void _writeToDB() {
    DBHelper.writeExpenseList(this);
  }

  /// Adds an entry to the entries maps, without notifying listeners of the
  /// change.
  void _silentAdd(ExpenseEntry entry) {
    final key = DateKey(entry.date.year, entry.date.month);
    entries.putIfAbsent(key, () => []);
    entries[key]!.add(entry);
    total += entry.amount;
    _sortList(key);
    _writeToDB();
  }
}
