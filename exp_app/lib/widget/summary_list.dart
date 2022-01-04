import 'package:exp/model/date_to_amount.dart';
import 'package:exp/model/expense_summary.dart';
import 'package:exp/util/constant/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SummaryList extends StatelessWidget {
  final int listID;

  final _topPadding = const EdgeInsets.only(top: 20, bottom: 10);
  final _normalPadding = const EdgeInsets.symmetric(vertical: 10);
  final _bottomPadding = const EdgeInsets.only(top: 10, bottom: 20);

  const SummaryList({this.listID = -1, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseSummary>(builder: (context, summary, child) {
      List<DateToAmount> amounts =
          listID == -1 ? summary.amount() : summary.listAmount(listID);
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.1,
        ),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: amounts.length,
          itemBuilder: (context, index) => Padding(
            padding: index == 0
                ? _topPadding
                : index == amounts.length - 1
                    ? _bottomPadding
                    : _normalPadding,
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
