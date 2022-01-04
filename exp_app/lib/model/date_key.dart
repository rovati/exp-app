import 'package:flutter/material.dart';

/// Used to represent a map key based on a date with year and month.
class DateKey {
  final int year;
  final int month;

  DateKey(this.year, this.month);

  /// Returns a date key for the month after.
  DateKey next() {
    int nextYear = year;
    int nextMonth = month;
    if (month == 12) {
      nextYear += 1;
      nextMonth = 1;
    } else {
      nextMonth += 1;
    }
    return DateKey(nextYear, nextMonth);
  }

  /// Returns a date key for the previous month.
  DateKey prev() {
    int prevYear = year;
    int prevMonth = month;
    if (month == 1) {
      prevYear -= 1;
      prevMonth = 12;
    } else {
      prevMonth -= 1;
    }
    return DateKey(prevYear, prevMonth);
  }

  /// Returns true if this date is before the given date.
  /// NOTE returns false if the dates are the same.
  bool isPriorTo(DateKey other) {
    if (year < other.year) {
      return true;
    } else {
      if (year == other.year && month < other.month) {
        return true;
      }
    }
    return false;
  }

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
