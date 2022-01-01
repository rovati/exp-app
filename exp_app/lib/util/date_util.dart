import 'package:flutter/widgets.dart';

/// Utility class for dealing with dates. Also defines contants related to dates.
/// NOTE on dates validity:
/// - the years is valid if between minYear and current year included;
/// - the month is valid if between 1 and 12 included, or between 1 and current
///   month included in the case the year is the current year;
/// - the day is valid if between 1 and the number of days of the month of the
///   given year included, or between 1 and the current day ifn the case the
///   year and month are the current ones.
class DateUtil {
  static const int minYear = 2021;

  /// Returns the number of days in a month of a given year.
  static int maxDays(int year, int month) {
    if (month == 2) {
      return (year % 400 == 0 || (year % 4 == 00 && !(year % 100 == 0)))
          ? 29
          : 28;
    } else {
      if (month < 8) {
        return month % 2 == 0 ? 30 : 31;
      } else {
        return month % 2 == 0 ? 31 : 30;
      }
    }
  }

  /// Clamps the input to a valid year
  static void clampYear(TextEditingController contrYear) {
    final currVal = contrYear.text.isEmpty ? -1 : int.parse(contrYear.text);
    final currYear = DateTime.now().year;
    var correctedYear = contrYear.text;

    correctedYear = currVal > currYear ? currYear.toString() : correctedYear;
    if (contrYear.text.isNotEmpty) {
      correctedYear = currVal < DateUtil.minYear
          ? DateUtil.minYear.toString()
          : correctedYear;
    }
    contrYear.value = TextEditingValue(
      text: correctedYear,
      selection: TextSelection.collapsed(offset: correctedYear.length),
    );
  }

  /// Clamps the month to a valid one.
  /// NOTE Assumes current year value is valid.
  static void clampMonth(
      TextEditingController contrMonth, TextEditingController contrYear) {
    final currMonthVal =
        contrMonth.text.isEmpty ? -1 : int.parse(contrMonth.text);
    final currMonth = DateTime.now().month;
    final currYearVal = int.parse(contrYear.text);
    final currYear = DateTime.now().year;
    var correctedMonth = contrMonth.text;

    if (currYearVal == currYear && currMonthVal > currMonth) {
      correctedMonth = currMonth.toString();
    } else {
      if (contrMonth.text.isNotEmpty) {
        correctedMonth = currMonthVal < 1 ? 1.toString() : correctedMonth;
        correctedMonth = currMonthVal > 12 ? 12.toString() : correctedMonth;
      }
    }
    contrMonth.value = TextEditingValue(
      text: correctedMonth,
      selection: TextSelection.collapsed(offset: correctedMonth.length),
    );
  }

  /// Clamps the day to a valid one.
  /// NOTE Assumes current year and months are valid.
  static void clampDay(TextEditingController contrDay,
      TextEditingController contrMonth, TextEditingController contrYear) {
    final currDayVal = contrDay.text.isEmpty ? -1 : int.parse(contrDay.text);
    final currDay = DateTime.now().day;
    final currMonthVal = int.parse(contrMonth.text);
    final currMonth = DateTime.now().month;
    final currYearVal = int.parse(contrYear.text);
    final currYear = DateTime.now().year;
    var correctedDay = contrDay.text;

    if (currYearVal == currYear &&
        currMonthVal == currMonth &&
        currDayVal > currDay) {
      correctedDay = currDay.toString();
    } else {
      if (contrDay.text.isNotEmpty) {
        correctedDay = currDayVal < 1 ? 1.toString() : correctedDay;
        final maxDays = DateUtil.maxDays(currYearVal, currMonthVal);
        correctedDay = currDayVal > maxDays ? maxDays.toString() : correctedDay;
      }
    }
    contrDay.value = TextEditingValue(
      text: correctedDay,
      selection: TextSelection.collapsed(offset: correctedDay.length),
    );
  }

  /// If the input is empty, sets the year to minYear.
  static void clampEmptyYear(TextEditingController contrYear) {
    if (contrYear.text.isEmpty) {
      final text = DateUtil.minYear.toString();
      contrYear.value = TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      );
    }
  }

  /// If the input is empty, sets the month to 1.
  static void clampEmptyMonth(TextEditingController contrMonth) {
    if (contrMonth.text.isEmpty) {
      contrMonth.value = const TextEditingValue(
        text: '1',
        selection: TextSelection.collapsed(offset: 1),
      );
    }
  }

  /// If the input is empty, sets the day to 1.
  static void clampEmptyDay(TextEditingController contrDay) {
    if (contrDay.text.isEmpty) {
      contrDay.value = const TextEditingValue(
        text: '1',
        selection: TextSelection.collapsed(offset: 1),
      );
    }
  }
}
