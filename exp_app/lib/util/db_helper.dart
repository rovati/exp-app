import 'dart:convert';
import 'dart:io';

import 'package:exp/model/expense_entry.dart';
import 'package:exp/model/expense_list.dart';
import 'package:exp/util/constant/json_keys.dart';

import 'constant/paths_and_links.dart';
import 'constant/strings.dart';

/// Utility class for reading from and writing to local files.
/// NOTE for the moment only supports reading and writing expense lists.
class DBHelper {
  /* EXPOSED API */

  /// REVIEW for alpha release, to be modified
  static void writeListHeader() async {
    await _createDirs();
    final file = File(await PathOrLink.nameMapPath);
    final dummyMap = {
      1: {
        'name': 'PREV VERSION',
        'total': 0.00,
        'month': 0.00,
      },
    };
    file.writeAsString(jsonEncode(dummyMap).toString());
  }

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

  /// Writes the given list to a local file.
  static void writeList(ExpenseList list) async {
    await _createDirs();
    final listFile = File(await PathOrLink.listPath(list.id));
    listFile.writeAsString(jsonEncode(ExpenseList()).toString());
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
