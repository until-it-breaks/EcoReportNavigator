import 'package:app_client/data/data_repository.dart';
import 'package:app_client/models/section.dart';
import 'package:app_client/models/sections/strategy.dart';
import 'package:app_client/widgets/base_scaffold.dart';
import 'package:app_client/widgets/ranking_list.dart';
import 'package:flutter/material.dart';

class StrategyPage extends StatefulWidget {
  const StrategyPage({super.key});

  @override
  State<StrategyPage> createState() => _StrategyPageState();
}

class _StrategyPageState extends State<StrategyPage> {
  late Future<Section> _futureSection;

  @override
  void initState() {
    super.initState();
    _futureSection = DataRepository().fetchStrategySection();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Section>(
      future: _futureSection,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text("Errore: ${snapshot.error}")),
          );
        }
        final section = snapshot.data;
        if (section == null) {
          return const Scaffold(body: Center(child: Text("No data found")));
        }
        final strategyData = StrategyData.fromJson(section.data);
        return BaseScaffold(
          title: "Strategia",
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RankingList(rankings: strategyData.rankings),
              const SizedBox(height: 24),

              Text(
                "Strutture",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text("Scuole: ${strategyData.facilities.schoolAmount}"),
              Text("Dipartimenti: ${strategyData.facilities.departmentAmount}"),

              const SizedBox(height: 24),

              Text(
                "Costi Strategici",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              ...strategyData.strategicCosts.scopes.map(
                (scope) => Text("${scope.name}: ${scope.percentage}"),
              ),
            ],
          ),
        );
      },
    );
  }
}
