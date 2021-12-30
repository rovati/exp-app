import 'package:exp/model/ExpenseEntry.dart';
import 'package:exp/model/ExpenseList.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          /* const Center(
            child: NewEntryDialog(),
          ), */
        ],
      ),
    );
  }

  // TODO
  void _onPressedOpenDialog() {
    ExpenseList().add(ExpenseEntry('new', 0, DateTime.now()));
  }
}
