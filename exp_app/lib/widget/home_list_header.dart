import 'package:exp/model/home_list.dart';
import 'package:exp/screen/info_screen.dart';
import 'package:exp/util/constant/strings.dart';
import 'package:exp/util/constant/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class HomeListHeader extends StatelessWidget {
  const HomeListHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text(Strings.appName, style: TextStyles.white20B),
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
          Consumer<HomeList>(
            builder: (context, homelist, child) => Text(
                homelist.total.toStringAsFixed(2),
                style: TextStyles.white60),
          ),
          Consumer<HomeList>(
            builder: (context, expenselist, child) => Text(
                expenselist.thisMonthTotal.toStringAsFixed(2),
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
