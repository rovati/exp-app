import 'package:exp/model/date_key.dart';
import 'package:exp/model/date_to_amount.dart';
import 'package:exp/model/expense_summary.dart';
import 'package:exp/util/constant/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpSummaryList extends StatelessWidget {
  final int listID;

  final topPadding = const EdgeInsets.only(top: 20, bottom: 10);
  final normalPadding = const EdgeInsets.symmetric(vertical: 10);
  final bottomPadding = const EdgeInsets.only(top: 10, bottom: 20);

  const ExpSummaryList(this.listID, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseSummary>(builder: (context, summary, child) {
      List<DateToAmount> amounts = summary.listAmount(listID);
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.1,
        ),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: amounts.length,
          itemBuilder: (context, index) => Padding(
            padding: index == 0
                ? topPadding
                : index == amounts.length - 1
                    ? bottomPadding
                    : normalPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  amounts[index].keyToString(),
                  style: TextStyles.blue20,
                ),
                Text(
                  amounts[index].amountToString(),
                  style: TextStyles.blue20,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
