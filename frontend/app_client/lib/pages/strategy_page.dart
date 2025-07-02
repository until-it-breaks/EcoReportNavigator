import 'package:app_client/data/data_repository.dart';
import 'package:app_client/models/section.dart';
import 'package:app_client/models/sections/strategy.dart';
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
    return Scaffold(
      appBar: AppBar(title: const Text("Strategia")),
      body: FutureBuilder<Section>(
        future: _futureSection,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Errore: ${snapshot.error}"));
          }
          final Section? section = snapshot.data;
          if (section == null) {
            return const Center(child: Text("No data found"));
          }
          final StrategyData strategyData = StrategyData.fromJson(section.data);
          return Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RankingList(rankings: strategyData.rankings),
                  const SizedBox(height: 24),

                  Text(
                    "Strutture",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Scuole: ${strategyData.facilities.schoolAmount}"),
                      Text(
                        "Dipartimenti: ${strategyData.facilities.departmentAmount}",
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  Text(
                    "Costi Strategici",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                        strategyData.strategicCosts.scopes.map((scope) {
                          return Text("${scope.name}: ${scope.percentage}");
                        }).toList(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
