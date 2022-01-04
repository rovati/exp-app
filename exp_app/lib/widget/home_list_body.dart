import 'package:exp/model/home_list.dart';
import 'package:exp/model/list_info.dart';
import 'package:exp/util/constant/animations.dart';
import 'package:exp/util/constant/strings.dart';
import 'package:exp/util/constant/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'list_info_tile.dart';

/// Body of the Home Page, it shows the list of the expense lists or an
/// informative message if the list is empty.
class HomeListBody extends StatelessWidget {
  const HomeListBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Consumer<HomeList>(
      builder: (context, homelist, child) => AnimatedSwitcher(
          duration: Animations.animDur,
          child: homelist.lists.isEmpty
              ? Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Center(
                    child: Text(
                      Strings.emptyHomeBody,
                      style: TextStyles.lBlue20,
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: homelist.lists.length,
                  itemBuilder: (context, index) {
                    ListInfo info = homelist.lists[index];
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
                      child: ListInfoTile(info),
                    );
                  },
                )));
}
