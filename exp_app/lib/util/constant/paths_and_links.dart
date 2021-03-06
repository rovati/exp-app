import 'package:path_provider/path_provider.dart';

/// Strings for paths and links.
class PathOrLink {
  /* URLs */
  static String bugReportLink = 'https://github.com/rovati/exp-app/issues';

  /* PATHS */
  static Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<String> get listsDirectory async {
    return await localPath + '/lists';
  }

  static Future<String> get homeListPath async {
    return await localPath + '/homelist.json';
  }

  static Future<String> listPath(int listID) async {
    return await localPath + '/lists/' + listID.toString() + '.json';
  }
}
