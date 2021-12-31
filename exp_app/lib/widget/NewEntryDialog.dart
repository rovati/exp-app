import 'package:exp/util/DateUtil.dart';
import 'package:flutter/material.dart';

class NewEntryDialog extends StatefulWidget {
  const NewEntryDialog({Key? key}) : super(key: key);

  @override
  _NewEntryDialogState createState() => _NewEntryDialogState();
}

class _NewEntryDialogState extends State<NewEntryDialog> {
  final TextEditingController _contrTitle = TextEditingController();
  final TextEditingController _contrAmount = TextEditingController();
  final TextEditingController _contrYear = TextEditingController();
  final TextEditingController _contrMonth = TextEditingController();
  final TextEditingController _contrDay = TextEditingController();

  @override
  void initState() {
    super.initState();
    _contrYear.text = DateTime.now().year.toString();
    _contrMonth.text = DateTime.now().month.toString();
    _contrDay.text = DateTime.now().day.toString();
    _contrYear.addListener(_yearCallback);
    _contrMonth.addListener(_monthCallback);
    _contrDay.addListener(_dayCallback);
  }

  @override
  void dispose() {
    _contrTitle.dispose();
    _contrAmount.dispose();
    _contrYear.dispose();
    _contrMonth.dispose();
    _contrDay.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.20,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            child: TextField(
              controller: _contrTitle,
              maxLength: 15,
              style: const TextStyle(color: Colors.blue),
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                hintText: 'TITLE',
                hintStyle:
                    TextStyle(color: Colors.blue, fontStyle: FontStyle.italic),
                border: InputBorder.none,
                counterText: '',
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            child: TextField(
              controller: _contrAmount,
              maxLength: 7,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.blue),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'AMOUNT',
                hintStyle:
                    TextStyle(color: Colors.blue, fontStyle: FontStyle.italic),
                border: InputBorder.none,
                counterText: '',
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.15,
                child: TextField(
                  controller: _contrYear,
                  maxLength: 4,
                  style: const TextStyle(color: Colors.blue),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    /* hintText: 'YYYY',
                    hintStyle: TextStyle(color: Colors.blue), */
                    border: InputBorder.none,
                    counterText: '',
                  ),
                ),
              ),
              const Text('-'),
              Container(
                width: MediaQuery.of(context).size.width * 0.1,
                child: TextField(
                  controller: _contrMonth,
                  maxLength: 2,
                  style: const TextStyle(color: Colors.blue),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    /* hintText: 'MM',
                    hintStyle: TextStyle(color: Colors.blue), */
                    border: InputBorder.none,
                    counterText: '',
                  ),
                ),
              ),
              const Text('-'),
              Container(
                width: MediaQuery.of(context).size.width * 0.1,
                child: TextField(
                  controller: _contrDay,
                  maxLength: 2,
                  style: const TextStyle(color: Colors.blue),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    /* hintText: 'DD',
                    hintStyle: TextStyle(color: Colors.blue), */
                    border: InputBorder.none,
                    counterText: '',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

/* #### CALLBACKS ####

  These callbacks are defined to check the input date and make it valid.
  A valid date is considered to be between January 1st 2021 and the current
  date.

  REVIEW might be changed later to accept future dates, so that to addn planned
  expenses. */

  void _yearCallback() {
    clampEmptyMonth();
    clampEmptyDay();
    if (_contrYear.text.length == 4) {
      clampYear();
      clampMonth();
      clampDay();
    }
  }

  void _monthCallback() {
    clampEmptyYear();
    clampEmptyDay();
    if (_contrYear.text.length != 4) {
      clampYear();
    }
    clampMonth();
    if (_contrMonth.text.isNotEmpty) {
      clampDay();
    }
  }

  void _dayCallback() {
    clampEmptyYear();
    clampEmptyMonth();
    if (_contrYear.text.length != 4) {
      clampYear();
      clampMonth();
    }
    clampDay();
  }

  void clampYear() {
    final currVal = _contrYear.text.isEmpty ? -1 : int.parse(_contrYear.text);
    final currYear = DateTime.now().year;
    var correctedYear = _contrYear.text;

    correctedYear = currVal > currYear ? currYear.toString() : correctedYear;
    if (_contrYear.text.isNotEmpty) {
      correctedYear = currVal < DateUtil.minYear
          ? DateUtil.minYear.toString()
          : correctedYear;
    }
    _contrYear.value = TextEditingValue(
      text: correctedYear,
      selection: TextSelection.collapsed(offset: correctedYear.length),
    );
  }

  /// NOTE Assumes current year value is valid.
  void clampMonth() {
    final currMonthVal =
        _contrMonth.text.isEmpty ? -1 : int.parse(_contrMonth.text);
    final currMonth = DateTime.now().month;
    final currYearVal = int.parse(_contrYear.text);
    final currYear = DateTime.now().year;
    var correctedMonth = _contrMonth.text;

    if (currYearVal == currYear && currMonthVal > currMonth) {
      correctedMonth = currMonth.toString();
    } else {
      if (_contrMonth.text.isNotEmpty) {
        correctedMonth = currMonthVal < 1 ? 1.toString() : correctedMonth;
        correctedMonth = currMonthVal > 12 ? 12.toString() : correctedMonth;
      }
    }
    _contrMonth.value = TextEditingValue(
      text: correctedMonth,
      selection: TextSelection.collapsed(offset: correctedMonth.length),
    );
  }

  /// NOTE Assumes current year and months are valid
  void clampDay() {
    final currDayVal = _contrDay.text.isEmpty ? -1 : int.parse(_contrDay.text);
    final currDay = DateTime.now().day;
    final currMonthVal = int.parse(_contrMonth.text);
    final currMonth = DateTime.now().month;
    final currYearVal = int.parse(_contrYear.text);
    final currYear = DateTime.now().year;
    var correctedDay = _contrDay.text;

    if (currYearVal == currYear &&
        currMonthVal == currMonth &&
        currDayVal > currDay) {
      correctedDay = currDay.toString();
    } else {
      if (_contrDay.text.isNotEmpty) {
        correctedDay = currDayVal < 1 ? 1.toString() : correctedDay;
        final maxDays = DateUtil.maxDays(currYearVal, currMonthVal);
        correctedDay = currDayVal > maxDays ? maxDays.toString() : correctedDay;
      }
    }
    _contrDay.value = TextEditingValue(
      text: correctedDay,
      selection: TextSelection.collapsed(offset: correctedDay.length),
    );
  }

  void clampEmptyYear() {
    if (_contrYear.text.isEmpty) {
      final text = DateUtil.minYear.toString();
      _contrYear.value = TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      );
    }
  }

  void clampEmptyMonth() {
    if (_contrMonth.text.isEmpty) {
      _contrMonth.value = const TextEditingValue(
        text: '1',
        selection: TextSelection.collapsed(offset: 1),
      );
    }
  }

  void clampEmptyDay() {
    if (_contrDay.text.isEmpty) {
      _contrDay.value = const TextEditingValue(
        text: '1',
        selection: TextSelection.collapsed(offset: 1),
      );
    }
  }
}
