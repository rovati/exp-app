import 'package:exp/util/constant/json_keys.dart';

class ListInfo {
  final String name;
  final int id;
  double total;
  double monthTotal;

  ListInfo(this.name, this.id)
      : total = 0,
        monthTotal = 0;

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

  @override
  bool operator ==(Object other) {
    return (other is ListInfo && id == other.id);
  }

  @override
  int get hashCode => id.hashCode;
}
