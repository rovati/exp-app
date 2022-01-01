import 'package:exp/model/expense_entry.dart';
import 'package:exp/model/expense_list.dart';
import 'package:exp/util/constant/strings.dart';
import 'package:exp/util/constant/text_styles.dart';
import 'package:exp/util/date_util.dart';
import 'package:flutter/material.dart';

/// Widget for user input when creating new expense entries.
/// It allows choosing a title, an amount and the date of the expense.
class NewEntryDialog extends StatefulWidget {
  const NewEntryDialog({Key? key}) : super(key: key);

  @override
  NewEntryDialogState createState() => NewEntryDialogState();
}

class NewEntryDialogState extends State<NewEntryDialog> {
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
              decoration: InputDecoration(
                hintText: Strings.nedTitle,
                hintStyle: TextStyles.blueI,
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
              decoration: InputDecoration(
                hintText: Strings.nedAmount,
                hintStyle: TextStyles.blueI,
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
                    border: InputBorder.none,
                    counterText: '',
                  ),
                ),
              ),
              const Text(DateUtil.dateFormatSep),
              Container(
                width: MediaQuery.of(context).size.width * 0.1,
                child: TextField(
                  controller: _contrMonth,
                  maxLength: 2,
                  style: const TextStyle(color: Colors.blue),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    counterText: '',
                  ),
                ),
              ),
              const Text(DateUtil.dateFormatSep),
              Container(
                width: MediaQuery.of(context).size.width * 0.1,
                child: TextField(
                  controller: _contrDay,
                  maxLength: 2,
                  style: const TextStyle(color: Colors.blue),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
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

  void createEntry() {
    final title = _contrTitle.text.isNotEmpty
        ? _contrTitle.text
        : Strings.expEntryDefTitle;
    final amount = _contrAmount.text.isNotEmpty
        ? _contrAmount.text
        : Strings.expEntryDefAmount;
    final date = DateTime(
      _contrYear.text.isNotEmpty
          ? int.parse(_contrYear.text)
          : DateUtil.minYear,
      _contrMonth.text.isNotEmpty ? int.parse(_contrMonth.text) : 1,
      _contrDay.text.isNotEmpty ? int.parse(_contrDay.text) : 1,
    );
    ExpenseList().add(ExpenseEntry(title, double.parse(amount), date));
  }

/* CALLBACKS
  defined to check the input date and make it valid.
  REVIEW might be changed later to accept future dates, so that to addn planned
  expenses. */

  void _yearCallback() {
    DateUtil.clampEmptyMonth(_contrMonth);
    DateUtil.clampEmptyDay(_contrDay);
    if (_contrYear.text.length == 4) {
      DateUtil.clampYear(_contrYear);
      DateUtil.clampMonth(_contrMonth, _contrYear);
      DateUtil.clampDay(_contrDay, _contrMonth, _contrYear);
    }
  }

  void _monthCallback() {
    DateUtil.clampEmptyYear(_contrYear);
    DateUtil.clampEmptyDay(_contrDay);
    if (_contrYear.text.length != 4) {
      DateUtil.clampYear(_contrYear);
    }
    DateUtil.clampMonth(_contrMonth, _contrYear);
    if (_contrMonth.text.isNotEmpty) {
      DateUtil.clampDay(_contrDay, _contrMonth, _contrYear);
    }
  }

  void _dayCallback() {
    DateUtil.clampEmptyYear(_contrYear);
    DateUtil.clampEmptyMonth(_contrMonth);
    if (_contrYear.text.length != 4) {
      DateUtil.clampYear(_contrYear);
      DateUtil.clampMonth(_contrMonth, _contrYear);
    }
    DateUtil.clampDay(_contrDay, _contrMonth, _contrYear);
  }
}
