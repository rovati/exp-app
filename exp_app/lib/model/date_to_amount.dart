import 'date_key.dart';

class DateToAmount {
  final DateKey key;
  final double amount;

  const DateToAmount(this.key, this.amount);

  String keyToString() => key.toPrettyString() + ':';
  String amountToString() => amount.toStringAsFixed(2);
}
