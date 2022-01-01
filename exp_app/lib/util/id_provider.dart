import 'package:shared_preferences/shared_preferences.dart';

/// Provider of unique ids for identification of expense lists.
/// NOTE currently not used.
class IDProvider {
  static Future<int> getNextId() async {
    final prefs = await SharedPreferences.getInstance();
    final currID = prefs.getInt('id') ?? 0;
    prefs.setInt('id', currID + 1);
    return currID + 1;
  }
}
