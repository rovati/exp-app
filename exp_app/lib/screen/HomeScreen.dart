import 'package:exp/screen/ExpenseScreen.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.dehaze),
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
                  Text(
                    "31.10 OVER BUDGET",
                    style: TextStyle(color: Colors.red[300]),
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
            const TextButton(
              onPressed: null,
              child: Text(
                "ADD MONTHLY BUDGET",
                style: TextStyle(color: Colors.blue),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
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
          MaterialPageRoute(
            builder: (context) => const ExpenseScreen(
              title: 'GROCERIES',
            ),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4625,
        decoration: BoxDecoration(
          gradient: color,
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
