import 'package:exp/model/expense_entry.dart';
import 'package:exp/model/expense_list.dart';
import 'package:exp/util/constant/animations.dart';
import 'package:exp/util/constant/strings.dart';
import 'package:exp/util/constant/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'expense_tile.dart';

/// Widget of the entries of a given ExpenseList.
/// It creates a ListView containing a ExpenseTile for each ExpenseEntry.
class ExpenseListBody extends StatelessWidget {
  final ExpenseList expenseList;
  const ExpenseListBody(this.expenseList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Consumer<ExpenseList>(
        builder: (context, expenselist, child) => AnimatedSwitcher(
          duration: Animations.animDur,
          child: expenselist.entries.isEmpty
              ? Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Center(
                    child: Text(
                      Strings.emptyExpBody,
                      style: TextStyles.lBlue20,
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: expenseList.allEntries.length,
                  itemBuilder: (context, index) {
                    ExpenseEntry entry = expenseList.allEntries[index];
                    final paddingFst = EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02,
                      bottom: MediaQuery.of(context).size.height * 0.005,
                      left: MediaQuery.of(context).size.width * 0.05,
                      right: MediaQuery.of(context).size.width * 0.05,
                    );
                    final padding = EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.005,
                      horizontal: MediaQuery.of(context).size.width * 0.05,
                    );
                    return Padding(
                      padding: index == 0 ? paddingFst : padding,
                      child: ExpenseTile(entry),
                    );
                  },
                ),
        ),
      );
}
