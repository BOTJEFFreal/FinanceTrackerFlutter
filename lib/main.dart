import 'package:financetracker/Screens/financePage.dart';
import 'package:financetracker/Screens/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


void main() {
  Firebase.initializeApp();
  runApp(LoginPage());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FinanceScreen()
    );
  }
}
