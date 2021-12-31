import 'dart:ui';

import 'package:exp/widget/InteractiveExpenseList.dart';
import 'package:exp/widget/NewEntryDialog.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    _dialogOpacity = 0.0;
    _isDialogVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // TODO remove appbar for easier blur effect
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.title),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: Stack(
        children: [
          Center(
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
                      const Text(
                        "TOTAL",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      const Text(
                        "315.70",
                        style: TextStyle(fontSize: 60, color: Colors.white),
                      ),
                      const Text(
                        "194.10",
                        style: TextStyle(fontSize: 35, color: Colors.white),
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
                const Expanded(
                  child: InteractiveExpenseList(),
                ),
              ],
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

  Widget fullDialog() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const NewEntryDialog(),
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

  // TODO add entry to expense list
  void _onTapConfirmNewEntry() {
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
