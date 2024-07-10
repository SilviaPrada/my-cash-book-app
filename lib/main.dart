import 'package:my_cash_book/constant/route_constants.dart';
import 'package:my_cash_book/pages/AddExpenditurePage.dart';
import 'package:my_cash_book/pages/AddIncomePage.dart';
import 'package:my_cash_book/pages/DetailCashFlowPage.dart';
import 'package:my_cash_book/pages/HomePage.dart';
import 'package:my_cash_book/pages/LoginPage.dart';
import 'package:my_cash_book/pages/SettingsPage.dart';
import 'package:my_cash_book/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UserProvider()),
  ], child: const MyApp()));
}

final routes = {
  loginRoute: (BuildContext context) => LoginPage(),
  homeRoute: (BuildContext context) => HomePage(),
  settingsRoute: (BuildContext context) => SettingsPage(),
  addExpenseRoute: (BuildContext context) => AddExpenditurePage(),
  addIncomeRoute: (BuildContext context) => AddIncomePage(),
  detailCashFlowRoute: (BuildContext context) => DetailCashFlowPage(),
};

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "MyCashBook App",
      theme: ThemeData(primaryColor: Colors.green.shade800),
      routes: routes,
    );
  }
}
