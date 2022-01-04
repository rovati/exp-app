import 'dart:ui';

import 'package:exp/model/expense_summary.dart';
import 'package:exp/model/home_list.dart';
import 'package:exp/util/constant/animations.dart';
import 'package:exp/util/constant/text_styles.dart';
import 'package:exp/widget/home_list_body.dart';
import 'package:exp/widget/home_list_header.dart';
import 'package:exp/widget/loading_indicator.dart';
import 'package:exp/widget/new_list_dialog.dart';
import 'package:exp/widget/summary_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Home page showing the various lists and a summary of all expense amounts.
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late double _dialogOpacity;
  late double _blurIntensity;
  late bool _isDialogVisible;
  late bool _showSummary;

  @override
  void initState() {
    super.initState();
    HomeList().load();
    ExpenseSummary().init();
    _dialogOpacity = 0.0;
    _blurIntensity = 0.0;
    _isDialogVisible = false;
    _showSummary = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            color: Colors.blue,
            height: MediaQuery.of(context).size.height * 0.05, // REVIEW
          ),
          SafeArea(
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.blue, Colors.blue.shade200]),
                      color: Colors.blue,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        HomeListHeader(_toggleSummary),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: InkWell(
                            onTap: _onPressedOpenDialog,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: Text('ADD NEW LIST',
                                    style: TextStyles.white15),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: Animations.animDur,
                      child: _showSummary
                          ? SummaryList()
                          : Consumer<HomeList>(
                              builder: (context, homelist, child) =>
                                  AnimatedSwitcher(
                                      duration: Animations.animDur,
                                      child: homelist.loaded
                                          ? const HomeListBody()
                                          : const LoadingIndicator()),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedOpacity(
            opacity: _blurIntensity,
            duration: Animations.animDur,
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 8.0,
                sigmaY: 8.0,
              ),
              child: Visibility(
                visible: _isDialogVisible,
                child: AnimatedOpacity(
                  opacity: _dialogOpacity,
                  duration: Animations.animHalfDur,
                  child: Center(
                    child: NewListDialog(fadeoutCallback: _onTapCloseDialog),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onPressedOpenDialog() {
    setState(() {
      _isDialogVisible = true;
      _dialogOpacity = 1.0;
      _blurIntensity = 1.0;
    });
  }

  void _onTapCloseDialog() {
    setState(() {
      _dialogOpacity = 0.0;
      _blurIntensity = 0.0;
    });
    Future.delayed(Animations.animDur, () {
      setState(() {
        _isDialogVisible = false;
      });
    });
  }

  void _toggleSummary() {
    setState(() {
      _showSummary = !_showSummary;
    });
  }
}
