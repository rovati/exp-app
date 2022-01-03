import 'package:exp/model/expense_entry.dart';
import 'package:exp/model/expense_list.dart';
import 'package:exp/util/constant/animations.dart';
import 'package:exp/util/constant/strings.dart';
import 'package:exp/util/constant/text_styles.dart';
import 'package:exp/util/date_util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Tile for the given ExpenseEntry in the ExpenseList.
/// It shows title, date and amount of the given entry. On long press it can be
/// deleted.
class ExpenseTile extends StatefulWidget {
  final ExpenseEntry entry;

  const ExpenseTile(this.entry, {Key? key}) : super(key: key);

  @override
  _ExpenseTileState createState() => _ExpenseTileState();
}

class _ExpenseTileState extends State<ExpenseTile> {
  var _isSelected = false;
  final Gradient whiteGr =
      const LinearGradient(colors: [Colors.white, Colors.white]);
  final Gradient redGr = LinearGradient(
      colors: [Colors.red.shade200, Colors.red],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: _onLongPressSelect,
      child: AnimatedContainer(
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.blue.shade300),
          gradient: _isSelected ? redGr : whiteGr,
        ),
        duration: Animations.animDur,
        child: AnimatedSwitcher(
          duration: Animations.animDur,
          child: _isSelected
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: _onTapDeselect,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Text(Strings.cancel, style: TextStyles.white15),
                      ),
                    ),
                    Text(Strings.sep, style: TextStyles.white35),
                    GestureDetector(
                      onTap: _onTapDelete,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(Strings.delete, style: TextStyles.white15),
                      ),
                    ),
                  ],
                )
              : Row(
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                    Expanded(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.entry.title,
                                    style: TextStyles.lBlue20),
                                Text(
                                    DateFormat(DateUtil.dateFormat)
                                        .format(widget.entry.date),
                                    style: TextStyles.lBlue15)
                              ],
                            ),
                          ),
                          Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                  widget.entry.amount.toStringAsFixed(2),
                                  style: TextStyles.lBlue30)),
                        ],
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                  ],
                ),
        ),
      ),
    );
  }

  void _onLongPressSelect() {
    if (!_isSelected) {
      setState(() {
        _isSelected = !_isSelected;
      });
    }
  }

  void _onTapDeselect() {
    if (_isSelected) {
      setState(() {
        _isSelected = !_isSelected;
      });
    }
  }

  void _onTapDelete() {
    _onTapDeselect();
    ExpenseList().remove(widget.entry);
  }
}
