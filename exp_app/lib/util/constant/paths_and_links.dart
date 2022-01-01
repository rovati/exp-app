import 'package:path_provider/path_provider.dart';

class PathOrLink {
  /* LINKS */
  static String bugReportLink = 'https://github.com/rovati/exp-app/issues';

  /* PATHS */
  static Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<String> get listsDirectory async {
    return await localPath + '/lists';
  }

  static Future<String> get nameMapPath async {
    return await localPath + '/tiles.json';
  }

  static Future<String> listPath(int listID) async {
    return await localPath + '/lists/' + listID.toString() + '.json';
  }
}
