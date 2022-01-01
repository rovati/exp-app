import 'dart:ui';

import 'package:exp/model/ExpenseEntry.dart';
import 'package:exp/model/ExpenseList.dart';
import 'package:exp/widget/ExpenseListHeader.dart';
import 'package:exp/widget/ExpenseTile.dart';
import 'package:exp/widget/LoadingIndicator.dart';
import 'package:exp/widget/NewEntryDialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final _animationDuration = 200;
  late double _dialogOpacity;
  late bool _isDialogVisible;
  late GlobalKey<NewEntryDialogState> _dialogKey;

  @override
  void initState() {
    super.initState();
    // REVIEW modify to take id from home screen push
    ExpenseList().load(1);
    _dialogOpacity = 0.0;
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
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: Text(
                                  // REVIEW use constant
                                  'ADD NEW ENTRY',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
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
                                  ? entriesList(expenselist)
                                  : const LoadingIndicator()),
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedOpacity(
            opacity: _dialogOpacity,
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
                    child: fullDialog(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget entriesList(ExpenseList expenselist) => ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: expenselist.allEntries.length,
        itemBuilder: (context, index) {
          ExpenseEntry entry = expenselist.allEntries[index];
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
            child: ExpenseTile(entry),
          );
        },
      );

  Widget fullDialog() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        NewEntryDialog(key: _dialogKey),
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.075,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: InkWell(
            onTap: _onTapConfirmNewEntry,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(
                  'CONFIRM',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _onPressedOpenDialog() {
    setState(() {
      _isDialogVisible = true;
      _dialogOpacity = 1.0;
    });
  }

  void _onTapConfirmNewEntry() {
    _dialogKey.currentState?.createEntry();
    setState(() {
      _dialogOpacity = 0.0;
    });
    Future.delayed(Duration(milliseconds: _animationDuration), () {
      setState(() {
        _isDialogVisible = false;
      });
    });
  }
}
