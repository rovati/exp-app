import 'package:exp/util/constant/json_keys.dart';
import 'package:exp/util/db_helper.dart';
import 'package:flutter/material.dart';

import 'date_key.dart';
import 'list_info.dart';

class HomeList extends ChangeNotifier {
  static final HomeList _list = HomeList._internal();
  late List<ListInfo> lists;
  late double total;
  late bool loaded;
  late int id;

  factory HomeList() {
    return _list;
  }

  /// Set default values, indicating the lists haven't been loaded yet.
  HomeList._internal() {
    loaded = false;
    id = -1;
    total = 0.00;
    lists = [];
    notifyListeners();
  }

  /// Loads the list from the local files and sort it. Notifies listeners.
  void load() async {
    List<ListInfo> res = await DBHelper.getHomeList();
    for (ListInfo info in res) {
      _silentAdd(info);
    }
    _sortList();
    loaded = true;
    notifyListeners();
  }

  /// Adds the element to the list, sorts the list and notifies listeners.
  void add(ListInfo info) {
    _silentAdd(info);
    _sortList();
    notifyListeners();
  }

  void modify(ListInfo info) {
    if (lists.contains(info)) {
      final old = lists[lists.indexOf(info)];
      total -= old.total;
      lists.remove(old);
    }
    add(info);
  }

  /// Removes the element from the list. Notifies Listeners.
  void remove(ListInfo info) {
    final res = lists.remove(info);
    if (res) {
      total -= info.total;
    }
    DBHelper.writeHomeList(true);
    notifyListeners();
  }

  /// Total expense amount for the current month.
  double get thisMonthTotal {
    double partial = 0.00;
    for (ListInfo info in lists) {
      partial += info.monthTotal;
    }
    return partial;
  }

  // TODO
  // REVIEW requires design review to have access to expense lists!
  /// Returns the amount of all lists expenses for the given year-month.
  double totalFor(DateKey month) {
    throw UnimplementedError();
  }

  Map<String, dynamic> toJson() {
    return {
      JSONKeys.homeListlists: lists.map((e) => e.toJson()).toList(),
    };
  }

  /// Adds the element to the list without notifying the listeners.
  /// It does not add an element if already one with same id is in the list. In
  /// that case, it removes the old element before adding the new one, and
  /// updates the total accordingly.
  void _silentAdd(ListInfo info) {
    lists.add(info);
    total += info.total;
    DBHelper.writeHomeList(false);
  }

  void _sortList() {
    lists.sort((e1, e2) => e1.id < e2.id ? 1 : -1);
  }
}
