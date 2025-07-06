import 'package:app_client/ui/pages/economic_page.dart';
import 'package:app_client/ui/pages/environment_page.dart';
import 'package:app_client/ui/pages/people_page.dart';
import 'package:app_client/ui/pages/research_page.dart';
import 'package:app_client/ui/pages/society_page.dart';
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
  AppRoutes.research: (context) => const ResearchPage(),
  AppRoutes.people: (context) => const PeoplePage(),
  AppRoutes.society: (context) => const SocietyPage(),
  AppRoutes.environment: (context) => const EnvironmentPage(),
};
