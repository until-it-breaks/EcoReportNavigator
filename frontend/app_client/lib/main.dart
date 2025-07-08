import 'package:app_client/routes/app_routes.dart';
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
      initialRoute: AppRoute.welcome.path,
      routes: appRoutes,
    );
  }
}
