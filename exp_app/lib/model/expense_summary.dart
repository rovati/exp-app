import 'package:exp/model/date_key.dart';
import 'package:exp/model/date_to_amount.dart';
import 'package:exp/util/constant/json_keys.dart';
import 'package:exp/util/db_helper.dart';
import 'package:flutter/material.dart';

import 'expense_entry.dart';

/// Model for keeping track of expense amounts for the various months.
class ExpenseSummary extends ChangeNotifier {
  static final ExpenseSummary _summary = ExpenseSummary._internal();

  // DateKey is mapped to a map from list id to the amount of that list.
  Map<DateKey, Map<int, double>> _amounts;
  DateKey _oldestDate;

  factory ExpenseSummary() => _summary;

  ExpenseSummary._internal()
      : _amounts = {},
        _oldestDate = DateKey(DateTime.now().year, DateTime.now().month);

  /// Initializes internal values with all entires of all lists.
  void init() async {
    _amounts.clear();
    _oldestDate = DateKey(DateTime.now().year, DateTime.now().month);
    List<Map<String, dynamic>> res = await DBHelper.getExpenseLists();
    Map<int, List<ExpenseEntry>> elaborated = {};
    // Convert expense lists raw data into a map {listID -> expenses of the list}
    for (Map<String, dynamic> listMap in res) {
      if (listMap.containsKey(JSONKeys.expListID) &&
          listMap.containsKey(JSONKeys.expListEntries)) {
        List<ExpenseEntry> entries = [];
        for (var entry in listMap[JSONKeys.expListEntries]) {
          entries.add(ExpenseEntry.fromJson(entry));
        }
        elaborated[listMap[JSONKeys.expListID]] = entries;
      }
    }
    for (int listID in elaborated.keys) {
      for (ExpenseEntry entry in elaborated[listID]!) {
        _silentAdd(listID, entry);
      }
    }
    notifyListeners();
  }

  void addEntry(int listID, ExpenseEntry entry) {
    _silentAdd(listID, entry);
    notifyListeners();
  }

  void removeEntry(int listID, ExpenseEntry entry) {
    final key = DateKey(entry.date.year, entry.date.month);
    final amount = entry.amount;
    if (_amounts.containsKey(key) && _amounts[key]!.containsKey(listID)) {
      _amounts[key]![listID] = _amounts[key]![listID]! - amount;
    }
    notifyListeners();
  }

  void removeList(int listID) {
    for (DateKey k in _amounts.keys) {
      _amounts[k]!.remove(listID);
    }
    notifyListeners();
  }

  /// Returns a list of each month total expense with one entry each month from
  /// the current month down to oldest date with an expense.
  /// NOTE fills with 0 where there was no registered expenses.
  List<DateToAmount> amount() {
    DateKey currentDateKey = DateKey(DateTime.now().year, DateTime.now().month);
    List<DateToAmount> res = [];
    while (!currentDateKey.isPriorTo(_oldestDate)) {
      if (_amounts.containsKey(currentDateKey)) {
        res.add(_monthAmount(currentDateKey));
      }
      currentDateKey = currentDateKey.prev();
    }
    return res;
  }

  /// Returns a list of each month expense of the given list with one entry each
  /// month from the oldest date with an expense up to the current month.
  /// NOTE fills with 0 where there was no registered expenses for the given
  /// list.
  List<DateToAmount> listAmount(int listID) {
    DateKey currentDateKey = DateKey(DateTime.now().year, DateTime.now().month);
    List<DateToAmount> res = [];
    while (!currentDateKey.isPriorTo(_oldestDate)) {
      if (_amounts.containsKey(currentDateKey) &&
          _amounts[currentDateKey]!.containsKey(listID)) {
        res.add(
            DateToAmount(currentDateKey, _amounts[currentDateKey]![listID]!));
      }
      currentDateKey = currentDateKey.prev();
    }
    return res;
  }

  void _silentAdd(int listID, ExpenseEntry entry) {
    final key = DateKey(entry.date.year, entry.date.month);
    final amount = entry.amount;
    if (!_amounts.containsKey(key)) {
      _amounts[key] = {};
    }
    if (!_amounts[key]!.containsKey(listID)) {
      _amounts[key]![listID] = 0;
    }
    _amounts[key]![listID] = _amounts[key]![listID]! + amount;
    _oldestDate = key.isPriorTo(_oldestDate) ? key : _oldestDate;
  }

  /// Accumulates the amounts of the various lits for a given date key.
  DateToAmount _monthAmount(DateKey key) {
    double monthTot = 0;
    for (int id in _amounts[key]!.keys) {
      monthTot += _amounts[key]![id]!;
    }
    return DateToAmount(key, monthTot);
  }
}
