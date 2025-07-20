import 'package:insightviewer/core/app_chapter.dart';
import 'package:insightviewer/core/topic_keys.dart';
import 'package:insightviewer/data/data_repository.dart';
import 'package:insightviewer/data/models/topics/strategy.dart/facilities.dart';
import 'package:insightviewer/data/models/topics/strategy.dart/strategic_costs.dart';
import 'package:insightviewer/data/models/topics/strategy.dart/university_ranking.dart';
import 'package:insightviewer/ui/pages/chapter_page.dart';
import 'package:insightviewer/ui/widgets/strategy/facilities_card.dart';
import 'package:insightviewer/ui/widgets/strategy/ranking_grid.dart';
import 'package:insightviewer/ui/widgets/strategy/strategic_costs_pie_chart.dart';
import 'package:flutter/material.dart';

class StrategyPage extends StatelessWidget {
  const StrategyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChapterPage<_StrategyTopics>(
      chapter: AppChapter.strategy,
      fetcher: _fetchStrategyTopics,
      builder: (context, data) {
        final rankings = data.rankings;
        final facilities = data.facilities;
        final strategicCosts = data.strategicCosts;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12,
          children: [
            if (rankings != null) RankingGrid(rankings: rankings),
            if (facilities != null) FacilitiesCard(facilities: facilities),
            if (strategicCosts != null)
              StrategicCostsPieChart(data: strategicCosts),
          ],
        );
      },
    );
  }
}

Future<_StrategyTopics> _fetchStrategyTopics(int chapterId) async {
  final repo = DataRepository();

  final rankingsFuture = repo.fetchTopic(
    AppChapter.strategy,
    StrategyTopicsKeys.ranking,
  );
  final facilitiesFuture = repo.fetchTopic(
    AppChapter.strategy,
    StrategyTopicsKeys.facilities,
  );
  final costsFuture = repo.fetchTopic(
    AppChapter.strategy,
    StrategyTopicsKeys.strategicCosts,
  );

  List<UniversityRanking>? rankings;
  try {
    final topic = await rankingsFuture;
    rankings = UniversityRanking.listFromJson(
      topic.data["dati"] as List<dynamic>,
    );
  } catch (e, st) {
    debugPrint('Error loading [${StrategyTopicsKeys.ranking}]: $e\n$st');
  }

  Facilities? facilities;
  try {
    final topic = await facilitiesFuture;
    facilities = Facilities.fromJson(topic.data);
  } catch (e, st) {
    debugPrint('Error loading [${StrategyTopicsKeys.facilities}]: $e\n$st');
  }

  StrategicCosts? strategicCosts;
  try {
    final topic = await costsFuture;
    strategicCosts = StrategicCosts.fromJson(topic.data);
  } catch (e, st) {
    debugPrint('Error loading [${StrategyTopicsKeys.strategicCosts}]: $e\n$st');
  }

  return _StrategyTopics(
    rankings: rankings,
    facilities: facilities,
    strategicCosts: strategicCosts,
  );
}

class _StrategyTopics {
  final List<UniversityRanking>? rankings;
  final Facilities? facilities;
  final StrategicCosts? strategicCosts;

  _StrategyTopics({
    required this.rankings,
    required this.facilities,
    required this.strategicCosts,
  });
}
