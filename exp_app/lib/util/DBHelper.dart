import 'dart:convert';
import 'dart:io';

import 'package:exp/model/ExpenseEntry.dart';
import 'package:path_provider/path_provider.dart';

import 'DateUtil.dart';

class BHelper {
  static Future<List<ExpenseEntry>> getExpenseEntries(int id) async {
    await createDirs();
    final file = await getListPath(id);
    return buildList(jsonDecode(file.readAsStringSync()));
  }

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> getListPath(int id) async {
    final path = File(await _localPath + '/lists/' + id.toString() + '.json');
    if (!path.existsSync()) {
      createEmptyList(path);
    }
    return path;
  }

  static void createEmptyList(File f) {
    Map<String, dynamic> newFile = {};
    newFile['entries'] = [];
    f.writeAsString(jsonEncode(newFile).toString());
  }

  static Future<void> createDirs() async {
    Directory listsDir = Directory(await _localPath + '/lists');
    if (!listsDir.existsSync()) {
      await listsDir.create();
    }
    /* getPathForOrdering().then((file) {
      if (!file.existsSync()) {
        file.writeAsString(// TODO);
      }
    }); */
  }

  static Future<List<File>> filterFiles(Directory dir) async {
    List<File> files = [];
    await for (var entity in dir.list()) {
      if (entity is File) {
        files.add(entity);
      }
    }
    return files;
  }

  static List<ExpenseEntry> buildList(Map<String, dynamic> json) {
    if (!json.keys.contains('entries')) {
      return [ExpenseEntry('failed to read list', 0.00, DateTime.now())];
    } else {
      List<Map<String, dynamic>> list = json['entries'];
      List<ExpenseEntry> entries = [];
      for (Map<String, dynamic> entryJson in list) {
        entries.add(buildEntry(entryJson));
      }
      return entries;
    }
  }

  static ExpenseEntry buildEntry(Map<String, dynamic> json) {
    if (!json.keys.contains('title')) {
      json['title'] = 'problem loading entry...';
    }
    if (!json.keys.contains('amount')) {
      json['amount'] = 0.00;
    }
    if (!json.keys.contains('date')) {
      json['date'] = '2021-01-01';
    }
    return ExpenseEntry(
        json['title'], double.parse(json['amount']), buildDate(json['date']));
  }

  // REVIEW better date handling? there should not be errors here
  static DateTime buildDate(String s) {
    final split = s.split("-");
    final errorDate = DateTime(2021, 1, 1);
    if (split.length != 3) {
      return errorDate;
    } else {
      final year = int.parse(split[0]);
      final month = int.parse(split[1]);
      final day = int.parse(split[2]);
      if (year > DateTime.now().year ||
          year < DateUtil.minYear ||
          month < 1 ||
          month > 12 ||
          day < 1 ||
          day > 31) {
        return errorDate;
      } else {
        return DateTime(year, month, day);
      }
    }
  }
}
