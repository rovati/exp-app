import 'package:exp/model/expense_summary.dart';
import 'package:exp/util/constant/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'model/expense_list.dart';
import 'model/home_list.dart';
import 'screen/home_screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ExpenseList()),
      ChangeNotifierProvider(create: (_) => HomeList()),
      ChangeNotifierProvider(create: (_) => ExpenseSummary()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'EXP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(title: Strings.appName),
    );
  }
}
