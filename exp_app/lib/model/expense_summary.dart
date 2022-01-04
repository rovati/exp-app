import 'package:exp/model/date_key.dart';
import 'package:flutter/material.dart';

import 'expense_entry.dart';

class ExpenseSummary extends ChangeNotifier {
  static final ExpenseSummary _summary = ExpenseSummary._internal();

  // DateKey is mapped to a map from list id to the amount of that list.
  Map<DateKey, Map<int, double>> _amounts;
  DateKey _oldestDate;

  factory ExpenseSummary() => _summary;

  ExpenseSummary._internal()
      : _amounts = {},
        _oldestDate = DateKey(DateTime.now().year, DateTime.now().month);

  // TODO
  void init() {
    _amounts.clear();
    _oldestDate = DateKey(DateTime.now().year, DateTime.now().month);
    throw UnimplementedError();
    // receive json {id -> {expenselist data}} from dbhelper
    // generate map {id -> list[expenseentry]}
    // silentadd all entries
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
  }

  // TODO
  void removeList(int listID) {
    throw UnimplementedError();
  }

  /// Returns a list of each month total expense with one entry each month from
  /// the current month down to oldest date with an expense.
  /// NOTE fills with 0 where there was no registered expenses.
  List<double> amount() {
    DateKey currentDateKey = DateKey(DateTime.now().year, DateTime.now().month);
    List<double> res = [];
    while (_oldestDate.isPriorTo(currentDateKey)) {
      res.add(_monthAmount(currentDateKey));
      currentDateKey = currentDateKey.prev();
    }
    return res;
  }

  /// Returns a list of each month expense of the given list with one entry each
  /// month from the oldest date with an expense up to the current month.
  /// NOTE fills with 0 where there was no registered expenses for the given
  /// list.
  List<double> listAmount(int listID) {
    DateKey currentDateKey = DateKey(DateTime.now().year, DateTime.now().month);
    List<double> res = [];
    while (_oldestDate.isPriorTo(currentDateKey)) {
      if (!_amounts.containsKey(currentDateKey) ||
          !_amounts[currentDateKey]!.containsKey(listID)) {
        res.add(0);
      } else {
        res.add(_amounts[currentDateKey]![listID]!);
      }
      currentDateKey = currentDateKey.prev();
    }
    return res;
  }

  // TODO
  /// Returns the total expense for the given year-month.
  double amountFor(DateKey key) {
    throw UnimplementedError();
  }

  // TODO
  /// Returns the expense of the given list for the given year-month.
  double listAmountFor(int listID, DateKey key) {
    throw UnimplementedError();
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
  double _monthAmount(DateKey key) {
    double monthTot = 0;
    if (!_amounts.containsKey(key)) {
      return 0;
    } else {
      for (int id in _amounts[key]!.keys) {
        monthTot += _amounts[key]![id]!;
      }
      return monthTot;
    }
  }
}
