import 'package:app_client/routes/app_routes.dart';
import 'package:flutter/material.dart';

enum DataCategory {
  strategy(AppRoute.strategy, Icons.insights, 'Strategia'),
  economic(AppRoute.economic, Icons.bar_chart, 'Valore Economico'),
  teaching(AppRoute.teaching, Icons.school, 'Didattica'),
  research(AppRoute.research, Icons.science, 'Ricerca'),
  people(AppRoute.people, Icons.people, 'Persone'),
  society(AppRoute.society, Icons.diversity_3, 'Società'),
  environment(AppRoute.environment, Icons.energy_savings_leaf, 'Ambiente');

  final AppRoute route;
  final IconData icon;
  final String name;

  const DataCategory(this.route, this.icon, this.name);
}
