import 'dart:ui';

import 'package:exp/model/DateKey.dart';
import 'package:exp/model/ExpenseEntry.dart';
import 'package:exp/model/ExpenseList.dart';
import 'package:exp/widget/ExpenseTile.dart';
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
  final animation_duration = 200;
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
                  // appbar
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
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              'GROCERIES',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const Text(
                          "TOTAL",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        Consumer<ExpenseList>(
                          builder: (context, expenselist, child) => Text(
                            expenselist.total.toStringAsFixed(2),
                            style: const TextStyle(
                                fontSize: 60, color: Colors.white),
                          ),
                        ),
                        Consumer<ExpenseList>(
                          builder: (context, expenselist, child) => Text(
                            expenselist
                                .totalFor(DateKey(
                                    DateTime.now().year, DateTime.now().month))
                                .toStringAsFixed(2),
                            style: const TextStyle(
                                fontSize: 35, color: Colors.white),
                          ),
                        ),
                        const Text(
                          "THIS MONTH",
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: LinearProgressIndicator(
                            value: 194.10 / 200,
                            backgroundColor: Colors.white,
                            color: Colors.green.shade200,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: _onPressedOpenDialog,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      alignment: Alignment.center,
                      child: const Text(
                        'ADD NEW ENTRY',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Consumer<ExpenseList>(
                      builder: (context, expenselist, child) =>
                          AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              child: expenselist.loaded
                                  ? entriesList(expenselist)
                                  : loadingProgress()),
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedOpacity(
            opacity: _dialogOpacity,
            duration: Duration(milliseconds: animation_duration),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 8.0,
                sigmaY: 8.0,
              ),
              child: Visibility(
                visible: _isDialogVisible,
                child: AnimatedOpacity(
                  opacity: _dialogOpacity,
                  duration: Duration(milliseconds: animation_duration ~/ 2),
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
          return Column(
            children: [
              ExpenseTile(entry),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              )
            ],
          );
        },
      );

  Widget loadingProgress() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.width * 0.3,
              child: const CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                "LOADING...",
                style: TextStyle(color: Colors.blue, fontSize: 25),
              ),
            ),
          ],
        ),
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
    Future.delayed(Duration(milliseconds: animation_duration), () {
      setState(() {
        _isDialogVisible = false;
      });
    });
  }
}
