import 'package:exp/model/ExpenseEntry.dart';
import 'package:exp/model/ExpenseList.dart';
import 'package:flutter/material.dart';

import 'ExpenseTile.dart';

/// Widget of the entries of a given ExpenseList.
/// It creates a ListView containing a ExpenseTile for each ExpenseEntry.
class ExpenseListBody extends StatelessWidget {
  final ExpenseList expenseList;
  const ExpenseListBody(this.expenseList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView.builder(
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
      );
}
