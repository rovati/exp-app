import 'package:exp/model/ExpenseEntry.dart';
import 'package:exp/model/ExpenseList.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
              generateTile(entry),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              )
            ],
          );
        },
      ),
    );
  }

  Widget generateTile(ExpenseEntry entry) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        //gradient: color,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blue),
      ),
      child: Row(
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
                      Text(
                        entry.title,
                        style:
                            const TextStyle(color: Colors.blue, fontSize: 20),
                      ),
                      Text(
                        DateFormat('yyyy-MM-dd').format(entry.date),
                        style:
                            const TextStyle(color: Colors.blue, fontSize: 15),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    entry.amount.toStringAsFixed(2),
                    style: const TextStyle(color: Colors.blue, fontSize: 30),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.05),
        ],
      ),
    );
  }
}
