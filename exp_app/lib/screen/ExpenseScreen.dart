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
      body: Center(
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
                  /* Text(
                    "5.90 UNDER BUDGET",
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ), */
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 7,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      const ExpenseTile(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExpenseTile extends StatelessWidget {
  const ExpenseTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        //gradient: color,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blue),
      ),
      child: Row(
        children: [
          SizedBox(width: MediaQuery.of(context).size.width * 0.05),
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Migros uhlala",
                        style: TextStyle(color: Colors.blue, fontSize: 20),
                      ),
                      Text(
                        "05.07.2021",
                        style: TextStyle(color: Colors.blue, fontSize: 15),
                      ),
                    ],
                  ),
                ),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "58.80",
                    style: TextStyle(color: Colors.blue, fontSize: 30),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.05),
        ],
      ),
    );
  }
}
