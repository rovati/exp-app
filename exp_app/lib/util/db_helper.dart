import 'dart:convert';
import 'dart:io';

import 'package:exp/model/expense_entry.dart';
import 'package:exp/model/expense_list.dart';
import 'package:path_provider/path_provider.dart';

/// Utility class for reading from and writing to local files.
/// NOTE for the moment only supports reading and writing expense lists.
class DBHelper {
  // TODO move paths to a different util class

  /* EXPOSED API */

  /// Reads and returns the list with the given id.
  static Future<List<ExpenseEntry>> getExpenseEntries(int id) async {
    await _createDirs();
    final file = await _getListFile(id);
    if (!file.existsSync()) {
      return [];
    } else {
      return _buildList(jsonDecode(file.readAsStringSync()));
    }
  }

  /// Writes the given list to a local file.
  static void writeList(ExpenseList list) async {
    await _createDirs();
    _getListFile(list.id).then((file) {
      final string = jsonEncode(ExpenseList()).toString();
      file.writeAsString(string);
    });
  }

  /* PRIVATE METHODS */

  // TODO move
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // TODO move
  static Future<File> _getListFile(int id) async {
    return File(await _localPath + '/lists/' + id.toString() + '.json');
  }

  /// Ensures the needed directories exist.
  static Future<void> _createDirs() async {
    Directory listsDir = Directory(await _localPath + '/lists');
    if (!listsDir.existsSync()) {
      await listsDir.create();
    }
  }

  /// Returns a list of ExpenseEntry created from the given json.
  static List<ExpenseEntry> _buildList(Map<String, dynamic> json) {
    if (!json.keys.contains('entries')) {
      return [ExpenseEntry('failed to read list', 0.00, DateTime.now())];
    } else {
      List<ExpenseEntry> entries = [];
      List<dynamic> list = json['entries'];
      entries.addAll(list.map((e) => _buildEntry(e)));
      return entries;
    }
  }

  /// Checks whether the given json contains all needed data ad returns an
  /// ExpenseEntry created from the json.
  static ExpenseEntry _buildEntry(Map<String, dynamic> json) {
    if (!json.keys.contains('title')) {
      json['title'] = 'problem loading entry...';
    }
    if (!json.keys.contains('amount')) {
      json['amount'] = '0.00';
    }
    if (!json.keys.contains('date')) {
      json['date'] = '2021-01-01';
    }
    return ExpenseEntry.fromJson(json);
  }
}
