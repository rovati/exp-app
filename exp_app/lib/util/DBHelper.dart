import 'dart:convert';
import 'dart:io';

import 'package:exp/model/ExpenseEntry.dart';
import 'package:exp/model/ExpenseList.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  static Future<List<ExpenseEntry>> getExpenseEntries(int id) async {
    await createDirs();
    final file = await getListFile(id);
    if (!file.existsSync()) {
      return [];
    } else {
      return buildList(jsonDecode(file.readAsStringSync()));
    }
  }

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> getListFile(int id) async {
    return File(await _localPath + '/lists/' + id.toString() + '.json');
  }

  static void createEmptyList(File f, int id) {
    Map<String, dynamic> newFile = {};
    newFile['entries'] = [];
    newFile['id'] = id;
    f.writeAsString(jsonEncode(newFile).toString());
  }

  static Future<void> createDirs() async {
    Directory listsDir = Directory(await _localPath + '/lists');
    if (!listsDir.existsSync()) {
      await listsDir.create();
    }
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

  static void writeList(ExpenseList list) async {
    await createDirs();
    getListFile(list.id).then((file) {
      final string = jsonEncode(ExpenseList()).toString();
      file.writeAsString(string);
    });
  }

  static List<ExpenseEntry> buildList(Map<String, dynamic> json) {
    if (!json.keys.contains('entries')) {
      return [ExpenseEntry('failed to read list', 0.00, DateTime.now())];
    } else {
      List<ExpenseEntry> entries = [];
      List<dynamic> list = json['entries'];
      entries.addAll(list.map((e) => buildEntry(e)));
      return entries;
    }
  }

  static ExpenseEntry buildEntry(Map<String, dynamic> json) {
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
