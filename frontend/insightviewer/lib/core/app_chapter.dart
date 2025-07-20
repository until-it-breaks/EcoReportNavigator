import 'package:insightviewer/routes/app_routes.dart';
import 'package:flutter/material.dart';

enum AppChapter {
  strategy(1, AppRoute.strategy, Icons.insights, 'Strategia'),
  economic(3, AppRoute.economic, Icons.bar_chart, 'Valore Economico'),
  teaching(4, AppRoute.teaching, Icons.school, 'Didattica'),
  research(5, AppRoute.research, Icons.science, 'Ricerca'),
  people(6, AppRoute.people, Icons.people, 'Persone'),
  society(7, AppRoute.society, Icons.diversity_3, 'Società'),
  environment(8, AppRoute.environment, Icons.energy_savings_leaf, 'Ambiente');

  final int id;
  final AppRoute route;
  final IconData icon;
  final String name;

  const AppChapter(this.id, this.route, this.icon, this.name);
}
