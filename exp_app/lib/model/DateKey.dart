import 'package:flutter/material.dart';

class DateKey {
  final int year;
  final int month;

  DateKey(this.year, this.month);

  @override
  bool operator ==(Object other) {
    if (other is DateKey && year == other.year && month == other.month) {
      return true;
    }
    return false;
  }

  @override
  int get hashCode => hashValues(year, month);
}
