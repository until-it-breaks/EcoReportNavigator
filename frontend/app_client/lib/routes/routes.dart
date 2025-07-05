import 'package:app_client/pages/strategy_page.dart';
import 'package:app_client/pages/welcome_page.dart';
import 'package:app_client/routes/app_routes.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> appRoutes = {
  AppRoutes.welcome: (context) => const WelcomePage(),
  AppRoutes.strategy: (context) => const StrategyPage(),
};
