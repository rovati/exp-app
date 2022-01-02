import 'dart:ui';

import 'package:exp/model/expense_list.dart';
import 'package:exp/util/constant/strings.dart';
import 'package:exp/util/constant/text_styles.dart';
import 'package:exp/widget/expense_list_body.dart';
import 'package:exp/widget/expense_list_header.dart';
import 'package:exp/widget/loading_indicator.dart';
import 'package:exp/widget/new_entry_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// WIdget representing the page for an expense list. It is composed by an upper
/// section containing a summary of total and current month amounts, and a
/// button to add new expenses, and by a lower part which contains the list of
/// entries of this list.
class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final _animationDuration = 200;
  late double _dialogOpacity;
  late double _blurIntensity;
  late bool _isDialogVisible;
  late GlobalKey<NewEntryDialogState> _dialogKey;

  @override
  void initState() {
    super.initState();
    // REVIEW modify to take id from home screen push
    ExpenseList().load(1);
    _dialogOpacity = 0.0;
    _blurIntensity = 0.0;
    _isDialogVisible = false;
    _dialogKey = GlobalKey();
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
                        const ExpenseListHeader(),
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
                    child: Consumer<ExpenseList>(
                      builder: (context, expenselist, child) =>
                          AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              child: expenselist.loaded
                                  ? ExpenseListBody(expenselist)
                                  : const LoadingIndicator()),
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedOpacity(
            opacity: _blurIntensity,
            duration: Duration(milliseconds: _animationDuration),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 8.0,
                sigmaY: 8.0,
              ),
              child: Visibility(
                visible: _isDialogVisible,
                child: AnimatedOpacity(
                  opacity: _dialogOpacity,
                  duration: Duration(milliseconds: _animationDuration ~/ 2),
                  child: Center(
                    child: NewEntryDialog(
                        cancelCallback: _onTapCloseDialog,
                        confirmCallback: _onTapConfirmNewEntry),
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

  void _onTapConfirmNewEntry() {
    _dialogKey.currentState?.createEntry();
    _onTapCloseDialog();
  }

  void _onTapCloseDialog() {
    setState(() {
      _dialogOpacity = 0.0;
      _blurIntensity = 0.0;
    });
    Future.delayed(Duration(milliseconds: _animationDuration), () {
      setState(() {
        _isDialogVisible = false;
      });
    });
  }
}
