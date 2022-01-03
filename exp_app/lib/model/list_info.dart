import 'package:exp/util/constant/json_keys.dart';

/// Model for information about an expense list, to show on a list tile. It
/// contains the list name, the id, the total and the total of the current month.
class ListInfo {
  final String name;
  final int id;
  double total;
  double monthTotal;

  ListInfo(this.name, this.id, {this.total = 0, this.monthTotal = 0});

  ListInfo.fromJson(Map<String, dynamic> json)
      : name = json[JSONKeys.listInfoName],
        id = json[JSONKeys.listInfoID],
        total = json[JSONKeys.listInfoTot],
        monthTotal = json[JSONKeys.listInfoMonthTot];

  Map<String, dynamic> toJson() {
    return {
      JSONKeys.listInfoName: name,
      JSONKeys.listInfoID: id,
      JSONKeys.listInfoTot: total,
      JSONKeys.listInfoMonthTot: monthTotal,
    };
  }

  /// Two lists are considered equals if their id is the same.
  @override
  bool operator ==(Object other) {
    return (other is ListInfo && id == other.id);
  }

  @override
  int get hashCode => id.hashCode;
}
