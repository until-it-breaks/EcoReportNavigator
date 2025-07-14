import 'package:insightviewer/ui/pages/economic_page.dart';
import 'package:insightviewer/ui/pages/environment_page.dart';
import 'package:insightviewer/ui/pages/people_page.dart';
import 'package:insightviewer/ui/pages/research_page.dart';
import 'package:insightviewer/ui/pages/society_page.dart';
import 'package:insightviewer/ui/pages/strategy_page.dart';
import 'package:insightviewer/ui/pages/teaching_page.dart';
import 'package:insightviewer/ui/pages/welcome_page.dart';
import 'package:flutter/material.dart';

enum AppRoute {
  welcome('/'),
  strategy('/strategy'),
  economic('/economic'),
  teaching('/teaching'),
  research('/research'),
  people('/people'),
  society('/society'),
  environment('/environment');

  final String path;
  const AppRoute(this.path);
}

final Map<String, WidgetBuilder> appRoutes = {
  AppRoute.welcome.path: (context) => const WelcomePage(),
  AppRoute.strategy.path: (context) => const StrategyPage(),
  AppRoute.economic.path: (context) => const EconomicPage(),
  AppRoute.teaching.path: (context) => const TeachingPage(),
  AppRoute.research.path: (context) => const ResearchPage(),
  AppRoute.people.path: (context) => const PeoplePage(),
  AppRoute.society.path: (context) => const SocietyPage(),
  AppRoute.environment.path: (context) => const EnvironmentPage(),
};
