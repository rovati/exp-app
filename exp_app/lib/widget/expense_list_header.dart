import 'package:exp/model/date_key.dart';
import 'package:exp/model/expense_list.dart';
import 'package:exp/screen/info_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

/// Widget containing the header of an ExpenseList.
/// It shows the cumulative amount of the entries, and the partial amount for
/// entries of the current month.
class ExpenseListHeader extends StatelessWidget {
  const ExpenseListHeader({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    // REVIEW use constant
                    'GROCERIES',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: InfoScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.info_outline),
                  color: Colors.white,
                ),
              )
            ],
          ),
          const Text(
            // REVIEW use constant
            "TOTAL",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          Consumer<ExpenseList>(
            builder: (context, expenselist, child) => Text(
              expenselist.total.toStringAsFixed(2),
              style: const TextStyle(fontSize: 60, color: Colors.white),
            ),
          ),
          Consumer<ExpenseList>(
            builder: (context, expenselist, child) => Text(
              expenselist
                  .totalFor(DateKey(DateTime.now().year, DateTime.now().month))
                  .toStringAsFixed(2),
              style: const TextStyle(fontSize: 35, color: Colors.white),
            ),
          ),
          const Text(
            // REVIEW use constant
            "THIS MONTH",
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: 10,
          ),
          // REVIEW remove for alpha
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: LinearProgressIndicator(
              value: 194.10 / 200,
              backgroundColor: Colors.white,
              color: Colors.green.shade200,
            ),
          ),
        ],
      );
}
