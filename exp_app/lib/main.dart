import 'package:exp/util/constant/strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/expense_list.dart';
import 'screen/expense_screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ExpenseList()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EXP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ExpenseScreen(title: Strings.appName),
    );
  }
}
