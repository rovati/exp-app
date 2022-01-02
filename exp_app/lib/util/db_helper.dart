import 'dart:convert';
import 'dart:io';

import 'package:exp/model/expense_entry.dart';
import 'package:exp/model/expense_list.dart';
import 'package:exp/model/list_info.dart';
import 'package:exp/util/constant/json_keys.dart';

import 'constant/paths_and_links.dart';
import 'constant/strings.dart';

/// Utility class for reading from and writing to local files.
/// NOTE for the moment only supports reading and writing expense lists.
class DBHelper {
  /* EXPOSED API */

  /// Reads and returns the list with the given id.
  static Future<List<ExpenseEntry>> getExpenseEntries(int id) async {
    await _createDirs();
    final file = File(await PathOrLink.listPath(id));
    if (!file.existsSync()) {
      return [];
    } else {
      return _buildList(jsonDecode(file.readAsStringSync()));
    }
  }

  // TODO
  /// Reads and returns the list of the expense lists info.
  static Future<List<ListInfo>> getHomeList() async {
    throw UnimplementedError();
  }

  /// Writes the given list to a local file.
  static void writeExpenseList() async {
    await _createDirs();
    final listFile = File(await PathOrLink.listPath(ExpenseList().id));
    listFile.writeAsString(jsonEncode(ExpenseList()).toString());
  }

  // TODO
  /// Writes the list of ExpenseLists to a local file.
  static void writeHomeList() async {
    throw UnimplementedError();
  }

  /* PRIVATE METHODS */

  /// Ensures the needed directories exist.
  static Future<void> _createDirs() async {
    Directory listsDir = Directory(await PathOrLink.listsDirectory);
    if (!listsDir.existsSync()) {
      await listsDir.create();
    }
  }

  // REVIEW define error ExpenseList and ExpenseEntry

  /// Returns a list of ExpenseEntry created from the given json.
  static List<ExpenseEntry> _buildList(Map<String, dynamic> json) {
    if (!json.keys.contains(JSONKeys.expListEntries)) {
      return [ExpenseEntry(Strings.dbFailedList, 0.00, DateTime.now())];
    } else {
      List<ExpenseEntry> entries = [];
      List<dynamic> list = json[JSONKeys.expListEntries];
      entries.addAll(list.map((e) => _buildEntry(e)));
      return entries;
    }
  }

  /// Checks whether the given json contains all needed data ad returns an
  /// ExpenseEntry created from the json.
  static ExpenseEntry _buildEntry(Map<String, dynamic> json) {
    if (!json.keys.contains(JSONKeys.expEntryTitle)) {
      json[JSONKeys.expEntryTitle] = Strings.dbFailedEntryTitle;
    }
    if (!json.keys.contains(JSONKeys.expEntryAmount)) {
      json[JSONKeys.expEntryAmount] = Strings.dbFailedEntryAmount;
    }
    if (!json.keys.contains(JSONKeys.expEntryDate)) {
      json[JSONKeys.expEntryDate] = Strings.dbFailedEntryDate;
    }
    return ExpenseEntry.fromJson(json);
  }
}
