import 'package:app_client/data/data_repository.dart';
import 'package:app_client/data/models/section.dart';
import 'package:app_client/data/models/sections/strategy.dart';
import 'package:app_client/ui/widgets/base_scaffold.dart';
import 'package:app_client/ui/widgets/strategy/facilities_card.dart';
import 'package:app_client/ui/widgets/strategy/ranking_list.dart';
import 'package:app_client/ui/widgets/strategy/strategic_costs_pie_chart.dart';
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
    _futureSection = DataRepository().fetchSection(ChapterEnum.strategy);
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
              FacilitiesCard(facilities: strategyData.facilities),

              const SizedBox(height: 24),

              StrategicCostsPieChart(data: strategyData.strategicCosts),
            ],
          ),
        );
      },
    );
  }
}
