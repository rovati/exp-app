import 'dart:ui';

import 'package:exp/model/expense_list.dart';
import 'package:exp/model/list_info.dart';
import 'package:exp/util/constant/animations.dart';
import 'package:exp/util/constant/strings.dart';
import 'package:exp/util/constant/text_styles.dart';
import 'package:exp/widget/expense_list_body.dart';
import 'package:exp/widget/expense_list_header.dart';
import 'package:exp/widget/summary_list.dart';
import 'package:exp/widget/loading_indicator.dart';
import 'package:exp/widget/new_entry_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// WIdget representing the page for an expense list. It is composed by an upper
/// section containing a summary of total and current month amounts, and a
/// button to add new expenses, and by a lower part which contains the list of
/// entries of this list.
class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({Key? key, required this.info}) : super(key: key);
  final ListInfo info;

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  late double _dialogOpacity;
  late double _blurIntensity;
  late bool _isDialogVisible;
  late bool _showSummary;

  @override
  void initState() {
    super.initState();
    ExpenseList().load(widget.info.id, widget.info.name);
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
                        ExpenseListHeader(widget.info.name, _toggleSummary),
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
                                child: Text(Strings.newEntryButton,
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
                          ? SummaryList(listID: widget.info.id)
                          : Consumer<ExpenseList>(
                              builder: (context, expenselist, child) =>
                                  AnimatedSwitcher(
                                      duration: Animations.animDur,
                                      child: expenselist.loaded
                                          ? ExpenseListBody(expenselist)
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
                    child: NewEntryDialog(fadeoutCallback: _onTapCloseDialog),
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
