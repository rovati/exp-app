import 'package:flutter/material.dart';

/// Used to represent a map key based on a date with year and month.
class DateKey {
  final int year;
  final int month;

  DateKey(this.year, this.month);

  /// Equality is defined as having same year and same month.
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
