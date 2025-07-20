import 'package:insightviewer/core/app_chapter.dart';
import 'package:insightviewer/core/topic_keys.dart';
import 'package:insightviewer/data/data_repository.dart';
import 'package:insightviewer/data/models/topics/environment/carbon_footprint.dart';
import 'package:insightviewer/data/models/topics/environment/energy_plan_milestone.dart';
import 'package:insightviewer/data/models/topics/environment/environment_summary.dart';
import 'package:insightviewer/ui/pages/chapter_page.dart';
import 'package:insightviewer/ui/widgets/environment/carbon_footprint_table.dart';
import 'package:insightviewer/ui/widgets/environment/environment_summary_grid.dart';
import 'package:insightviewer/ui/widgets/environment/green_milestones_table.dart';
import 'package:flutter/material.dart';

class EnvironmentPage extends StatelessWidget {
  const EnvironmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChapterPage<_EnvironmentTopics>(
      chapter: AppChapter.environment,
      fetcher: _fetchEnvironmentTopics,
      builder: (context, data) {
        final summary = data.summary;
        final milestones = data.milestones;
        final carbonFootprint = data.carbonFootprint;

        return Column(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (summary != null) EnvironmentSummaryGrid(summary: summary),
            if (milestones != null) MilestoneTable(milestones: milestones),
            if (carbonFootprint != null)
              CarbonFootprintTable(carbonFootprint: carbonFootprint),
          ],
        );
      },
    );
  }
}

Future<_EnvironmentTopics> _fetchEnvironmentTopics(int chapterId) async {
  final repo = DataRepository();

  final summaryFuture = repo.fetchTopic(
    AppChapter.environment,
    EnvironmentTopicsKeys.summary,
  );

  final milestonesFuture = repo.fetchTopic(
    AppChapter.environment,
    EnvironmentTopicsKeys.milestones,
  );

  final carbonFootprintFuture = repo.fetchTopic(
    AppChapter.environment,
    EnvironmentTopicsKeys.carbonFootprint,
  );

  EnvironmentSummary? summary;
  List<EnergyPlanMilestone>? milestones;
  CarbonFootprint? carbonFootprint;

  try {
    final topic = await summaryFuture;
    summary = EnvironmentSummary.fromJson(topic.data);
  } catch (e, st) {
    debugPrint('Error loading [${EnvironmentTopicsKeys.summary}]: $e\n$st');
  }

  try {
    final topic = await milestonesFuture;
    milestones = EnergyPlanMilestone.listFromJson(
      topic.data["valori"] as List<dynamic>,
    );
  } catch (e, st) {
    debugPrint('Error loading [${EnvironmentTopicsKeys.milestones}]: $e\n$st');
  }

  try {
    final topic = await carbonFootprintFuture;
    carbonFootprint = CarbonFootprint.fromJson(topic.data);
  } catch (e, st) {
    debugPrint(
      'Error loading [${EnvironmentTopicsKeys.carbonFootprint}]: $e\n$st',
    );
  }

  return _EnvironmentTopics(
    summary: summary,
    milestones: milestones,
    carbonFootprint: carbonFootprint,
  );
}

class _EnvironmentTopics {
  final EnvironmentSummary? summary;
  final List<EnergyPlanMilestone>? milestones;
  final CarbonFootprint? carbonFootprint;

  _EnvironmentTopics({
    required this.summary,
    required this.milestones,
    required this.carbonFootprint,
  });
}
