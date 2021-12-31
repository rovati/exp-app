import 'package:flutter/widgets.dart';

class DateUtil {
  static const int minYear = 2021;

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

  /// NOTE Assumes current year and months are valid
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

  static void clampEmptyYear(TextEditingController contrYear) {
    if (contrYear.text.isEmpty) {
      final text = DateUtil.minYear.toString();
      contrYear.value = TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      );
    }
  }

  static void clampEmptyMonth(TextEditingController contrMonth) {
    if (contrMonth.text.isEmpty) {
      contrMonth.value = const TextEditingValue(
        text: '1',
        selection: TextSelection.collapsed(offset: 1),
      );
    }
  }

  static void clampEmptyDay(TextEditingController contrDay) {
    if (contrDay.text.isEmpty) {
      contrDay.value = const TextEditingValue(
        text: '1',
        selection: TextSelection.collapsed(offset: 1),
      );
    }
  }
}
