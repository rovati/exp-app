import 'package:exp/util/constant/json_keys.dart';
import 'package:exp/util/date_util.dart';
import 'package:intl/intl.dart';

/// Immutable model for an expense. The object represents the name, the amount
/// and the date of an expense.
/// NOTE some implementations are to be updated for future use.
class ExpenseEntry {
  final String title;
  final double amount;
  final DateTime date;

  ExpenseEntry(this.title, this.amount, this.date);

  ExpenseEntry.fromJson(Map<String, dynamic> json)
      : title = json[JSONKeys.expEntryTitle],
        amount = json[JSONKeys.expEntryAmount] as double,
        date = _buildDate(json[JSONKeys.expEntryDate]);

  /// Serialization for saving to local DB.
  Map<String, dynamic> toJson() => {
        JSONKeys.expEntryTitle: title,
        JSONKeys.expEntryAmount: amount,
        JSONKeys.expEntryDate: DateFormat(DateUtil.dateFormat).format(date)
      };

  // NOTE loose check on the date. Might want to update.
  static DateTime _buildDate(String s) {
    final split = s.split(DateUtil.dateFormatSep);
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
