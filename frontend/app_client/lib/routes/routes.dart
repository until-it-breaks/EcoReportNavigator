import 'package:app_client/ui/pages/economic_page.dart';
import 'package:app_client/ui/pages/strategy_page.dart';
import 'package:app_client/ui/pages/teaching_page.dart';
import 'package:app_client/ui/pages/welcome_page.dart';
import 'package:app_client/routes/app_routes.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> appRoutes = {
  AppRoutes.welcome: (context) => const WelcomePage(),
  AppRoutes.strategy: (context) => const StrategyPage(),
  AppRoutes.economic: (context) => const EconomicPage(),
  AppRoutes.teaching: (context) => const TeachingPage(),
};
