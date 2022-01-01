import 'package:exp/model/DateKey.dart';
import 'package:exp/model/ExpenseList.dart';
import 'package:exp/screen/InfoScreen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class ExpenseListHeader extends StatefulWidget {
  const ExpenseListHeader({Key? key}) : super(key: key);

  @override
  _ELHeaderState createState() => _ELHeaderState();
}

class _ELHeaderState extends State<ExpenseListHeader> {
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
            "THIS MONTH",
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: 10,
          ),
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
