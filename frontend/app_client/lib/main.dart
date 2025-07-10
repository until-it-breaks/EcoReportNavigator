import 'package:app_client/routes/app_routes.dart';
import 'package:flutter/material.dart';

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.system);

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentTheme, _) {
        return MaterialApp(
          title: "Flutter JSON Demo",
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Colors.white,
            textTheme: const TextTheme(
              bodyMedium: TextStyle(color: Colors.black),
            ),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Colors.black,
            textTheme: const TextTheme(
              bodyMedium: TextStyle(color: Colors.white),
            ),
          ),
          themeMode: currentTheme,
          initialRoute: AppRoute.welcome.path,
          routes: appRoutes,
        );
      },
    );
  }
}
