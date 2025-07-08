import 'package:app_client/core/data_categories.dart';
import 'package:app_client/data/data_repository.dart';
import 'package:app_client/data/models/section.dart';
import 'package:app_client/data/models/sections/strategy.dart';
import 'package:app_client/ui/pages/section_page.dart';
import 'package:app_client/ui/widgets/base_scaffold.dart';
import 'package:app_client/ui/widgets/strategy/facilities_card.dart';
import 'package:app_client/ui/widgets/strategy/ranking_list.dart';
import 'package:app_client/ui/widgets/strategy/strategic_costs_pie_chart.dart';
import 'package:flutter/material.dart';

class StrategyPage extends SectionPage {
  const StrategyPage({super.key}) : super(chapter: ChapterEnum.strategy);

  @override
  Widget buildContent(BuildContext context, Section section) {
    final strategyData = StrategyData.fromJson(section.data);

    return BaseDataCategoryPageScaffold(
      category: DataCategory.strategy,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RankingList(rankings: strategyData.rankings),
          const SizedBox(height: 24),
          Text("Strutture", style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 8),
          FacilitiesCard(facilities: strategyData.facilities),
          const SizedBox(height: 24),
          StrategicCostsPieChart(data: strategyData.strategicCosts),
        ],
      ),
    );
  }
}
