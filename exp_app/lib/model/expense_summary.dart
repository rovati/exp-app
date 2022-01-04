import 'package:exp/model/date_key.dart';

class ExpenseSummary {
  static final ExpenseSummary _summary = ExpenseSummary._internal();

  // DateKey is mapped to a map from list id to the amount of that list.
  Map<DateKey, Map<int, double>> _amounts;
  DateKey _oldestDate;

  factory ExpenseSummary() => _summary;

  ExpenseSummary._internal()
      : _amounts = {},
        _oldestDate = DateKey(DateTime.now().year, DateTime.now().month);

  // TODO
  void addEntry(int listID, double amount) {
    throw UnimplementedError();
  }

  // TODO
  void removeEntry(int listID, double amount) {
    throw UnimplementedError();
  }

  // TODO
  void removeList(int listID) {
    throw UnimplementedError();
  }

  // TODO
  /// Returns a list of each month total expense with one entry each month from
  /// the oldest date with an expense up to the current month.
  /// NOTE fills with 0 where there was no registered expenses.
  List<double> amount() {
    throw UnimplementedError();
  }

  // TODO
  /// Returns a list of each month expense of the given list with one entry each
  /// month from the oldest date with an expense up to the current month.
  /// NOTE fills with 0 where there was no registered expenses for the given
  /// list.
  List<double> listAmount(int listID) {
    throw UnimplementedError();
  }

  // TODO
  /// Returns the total expense for the given year-month.
  double amountFor(DateKey key) {
    throw UnimplementedError();
  }

  // TODO
  /// Returns the expense of the given list for the given year-month.
  double listAmountFor(int listID, DateKey key) {
    throw UnimplementedError();
  }
}
