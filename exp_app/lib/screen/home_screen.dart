import 'package:exp/screen/expense_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'info_screen.dart';

// TODO refactor and comment after alpha release
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        Stack(
                          children: [
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                child: Text(
                                  'EXP',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
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
                        const Text(
                          "TOTAL",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        const Text(
                          "923.70",
                          style: TextStyle(fontSize: 60, color: Colors.white),
                        ),
                        const Text(
                          "431.10",
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
                            value: 400 / 431.10,
                            backgroundColor: Colors.red.shade200,
                            color: Colors.green.shade200,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        // first row
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.025,
                            ),
                            ExpenseTile(
                              LinearGradient(
                                colors: [Colors.purple, Colors.purple.shade200],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.025,
                            ),
                            ExpenseTile(
                              LinearGradient(
                                colors: [Colors.green, Colors.green.shade200],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.025,
                        ),
                        // second row
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.025,
                            ),
                            ExpenseTile(
                              LinearGradient(
                                colors: [Colors.amber, Colors.amber.shade200],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.025,
                            ),
                            ExpenseTile(
                              LinearGradient(
                                colors: [Colors.blue, Colors.blue.shade200],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.025,
                        ),
                        // third row
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.025,
                            ),
                            ExpenseTile(
                              LinearGradient(
                                colors: [Colors.red, Colors.red.shade200],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ExpenseTile extends StatelessWidget {
  final Gradient color;

  const ExpenseTile(this.color, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: const ExpenseScreen(
              title: 'GROCERIES',
            ),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4625,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.blue.shade200],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.023125,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.032,
                ),
                const Text(
                  "GROCERIES",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                const Text(
                  "319.30",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                const Text(
                  "120.90 MONTHLY",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.096,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
