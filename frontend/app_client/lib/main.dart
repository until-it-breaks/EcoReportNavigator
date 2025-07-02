import 'package:app_client/pages/strategy_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter JSON Demo",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const StrategyPage(),
    );
  }
}
