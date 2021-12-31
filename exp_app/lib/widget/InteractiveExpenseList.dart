import 'package:exp/model/ExpenseEntry.dart';
import 'package:exp/model/ExpenseList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ExpenseTile.dart';

class InteractiveExpenseList extends StatefulWidget {
  const InteractiveExpenseList({Key? key}) : super(key: key);

  @override
  _IntExpListState createState() => _IntExpListState();
}

class _IntExpListState extends State<InteractiveExpenseList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseList>(
      builder: (context, expenselist, child) => ListView.builder(
        itemCount: expenselist.allEntries.length,
        itemBuilder: (context, index) {
          ExpenseEntry entry = expenselist.allEntries[index];
          return Column(
            children: [
              ExpenseTile(entry),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              )
            ],
          );
        },
      ),
    );
  }
}
