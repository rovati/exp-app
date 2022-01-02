import 'package:exp/model/list_info.dart';
import 'package:exp/screen/expense_screen.dart';
import 'package:exp/util/constant/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class ListInfoTile extends StatelessWidget {
  final ListInfo info;

  const ListInfoTile(this.info, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: ExpenseScreen(
              title: info.name,
            ),
          ),
        );
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade300, Colors.blue.shade200],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(info.name, style: TextStyles.white20),
                  Text('THIS MONTH: ' + info.monthTotal.toStringAsFixed(2),
                      style: TextStyles.white15),
                ],
              ),
              Text(info.total.toStringAsFixed(2), style: TextStyles.white30),
            ],
          ),
        ),
      ),
    );
  }
}
