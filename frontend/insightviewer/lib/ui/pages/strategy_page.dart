import 'package:insightviewer/core/data_categories.dart';
import 'package:insightviewer/data/data_repository.dart';
import 'package:insightviewer/data/models/section.dart';
import 'package:insightviewer/data/models/sections/strategy.dart';
import 'package:insightviewer/ui/pages/section_page.dart';
import 'package:insightviewer/ui/widgets/base_scaffold.dart';
import 'package:insightviewer/ui/widgets/strategy/facilities_card.dart';
import 'package:insightviewer/ui/widgets/strategy/ranking_grid.dart';
import 'package:insightviewer/ui/widgets/strategy/strategic_costs_pie_chart.dart';
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
        spacing: 12,
        children: [
          RankingGrid(rankings: strategyData.rankings),
          FacilitiesCard(facilities: strategyData.facilities),
          StrategicCostsPieChart(data: strategyData.strategicCosts),
        ],
      ),
    );
  }
}
