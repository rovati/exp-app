import 'package:exp/util/constant/json_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provider of unique ids for identification of expense lists.
class IDProvider {
  static Future<int> getNextId() async {
    final prefs = await SharedPreferences.getInstance();
    final currID = prefs.getInt(JSONKeys.spID) ?? 0;
    prefs.setInt(JSONKeys.spID, currID + 1);
    return currID + 1;
  }

  /// Updates the current id with the given value.
  /// NOTE used when recovering old version lists.
  static void updateID(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final currID = prefs.getInt(JSONKeys.spID) ?? 0;
    if (currID < id) {
      prefs.setInt(JSONKeys.spID, id);
    }
  }
}
