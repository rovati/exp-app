import 'dart:convert';
import 'dart:io';

import 'package:exp/model/expense_entry.dart';
import 'package:exp/model/expense_list.dart';
import 'package:exp/model/home_list.dart';
import 'package:exp/model/list_info.dart';
import 'package:exp/util/constant/json_keys.dart';
import 'package:exp/util/id_provider.dart';

import 'constant/paths_and_links.dart';
import 'constant/strings.dart';

/// Utility class for reading from and writing to local files.
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

  /// Reads and returns the list of the expense lists info. Also recovers
  /// ExpenseLists from previous versions that do not have an associated
  /// ListInfo.
  static Future<List<ListInfo>> getHomeList() async {
    await _createDirs();
    final file = File(await PathOrLink.homeListPath);
    if (!file.existsSync()) {
      return _recoverPrevVerlists();
    } else {
      return _buildInfoList(jsonDecode(file.readAsStringSync()));
    }
  }

  // TODO retrieve all expense lists
  static Future<List<Map<String, dynamic>>> getExpenseLists() async {
    throw UnimplementedError();
  }

  /// Writes the given list to a local file.
  static void writeExpenseList() async {
    await _createDirs();
    final listFile = File(await PathOrLink.listPath(ExpenseList().id));
    listFile.writeAsString(jsonEncode(ExpenseList()).toString());
  }

  /// Writes the list of ExpenseLists to a local file.  If the write happens
  /// because of removing a list, it removes also removes the corresponding
  /// ExpenseList.
  static void writeHomeList(bool afterRemoval) async {
    await _createDirs();
    if (afterRemoval) {
      _removeDeletedLists();
    }
    final file = File(await PathOrLink.homeListPath);
    file.writeAsString(jsonEncode(HomeList()).toString());
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

  /// Returns a list of ListInfo created from the given json.
  static List<ListInfo> _buildInfoList(Map<String, dynamic> json) {
    if (!json.keys.contains(JSONKeys.homeListlists)) {
      return [];
    } else {
      List<dynamic> elems = json[JSONKeys.homeListlists];
      return elems.map((e) => ListInfo.fromJson(e)).toList();
    }
  }

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

  /// Generates ListInfo for versions prev to 0.2.0-alpha.
  static Future<List<ListInfo>> _recoverPrevVerlists() async {
    List<File> files = [];
    final Directory dir = Directory(await PathOrLink.listsDirectory);
    await for (var entity in dir.list()) {
      if (entity is File) {
        files.add(entity);
      }
    }

    List<Map<String, dynamic>> lists = [];
    for (File f in files) {
      lists.add(jsonDecode(f.readAsStringSync()));
    }
    List<ListInfo> infos = [];
    int maxID = 0;
    for (Map<String, dynamic> json in lists) {
      final int id = json[JSONKeys.expListID];
      maxID = id > maxID ? id : maxID;
      infos.add(ListInfo(Strings.dbPrevVerListName, id));
    }
    IDProvider.updateID(maxID);

    return infos;
  }

  /// Deletes files corresponding to lists that do not appear in the HomeList.
  static void _removeDeletedLists() async {
    List<int> validIDs = [];
    for (ListInfo info in HomeList().lists) {
      validIDs.add(info.id);
    }
    List<File> toBeRemoved = [];
    final Directory dir = Directory(await PathOrLink.listsDirectory);
    await for (var entity in dir.list()) {
      if (entity is File) {
        if (!validIDs.contains(
            jsonDecode(entity.readAsStringSync())[JSONKeys.expListID])) {
          toBeRemoved.add(entity);
        }
      }
    }
    for (File file in toBeRemoved) {
      file.deleteSync();
    }
  }
}
