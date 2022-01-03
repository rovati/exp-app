import 'package:exp/model/date_key.dart';
import 'package:exp/model/expense_list.dart';
import 'package:exp/screen/info_screen.dart';
import 'package:exp/util/constant/strings.dart';
import 'package:exp/util/constant/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

/// Widget containing the header of an ExpenseList.
/// It shows the cumulative amount of the entries, and the partial amount for
/// entries of the current month.
class ExpenseListHeader extends StatelessWidget {
  final String listName;
  const ExpenseListHeader(this.listName, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child:
                      Text(listName.toUpperCase(), style: TextStyles.white20B),
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
                        child: const InfoScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.info_outline),
                  color: Colors.white,
                ),
              )
            ],
          ),
          Text(Strings.total, style: TextStyles.white20),
          Consumer<ExpenseList>(
            builder: (context, expenselist, child) => Text(
                expenselist.total.toStringAsFixed(2),
                style: TextStyles.white60),
          ),
          Consumer<ExpenseList>(
            builder: (context, expenselist, child) => Text(
                expenselist
                    .totalFor(
                        DateKey(DateTime.now().year, DateTime.now().month))
                    .toStringAsFixed(2),
                style: TextStyles.white35),
          ),
          Text(Strings.thisMonth, style: TextStyles.white),
          /* const SizedBox(height: 10),
          // REVIEW remove for alpha
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: LinearProgressIndicator(
              value: 194.10 / 200,
              backgroundColor: Colors.white,
              color: Colors.green.shade200,
            ),
          ), */
        ],
      );
}
