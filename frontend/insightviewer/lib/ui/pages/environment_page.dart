import 'package:insightviewer/core/data_categories.dart';
import 'package:insightviewer/data/data_repository.dart';
import 'package:insightviewer/data/models/section.dart';
import 'package:insightviewer/data/models/sections/environment.dart';
import 'package:insightviewer/ui/pages/section_page.dart';
import 'package:insightviewer/ui/widgets/base_scaffold.dart';
import 'package:insightviewer/ui/widgets/environment/carbon_footprint_table.dart';
import 'package:insightviewer/ui/widgets/environment/environment_summary_grid.dart';
import 'package:insightviewer/ui/widgets/environment/green_milestones_table.dart';
import 'package:flutter/material.dart';

class EnvironmentPage extends SectionPage {
  const EnvironmentPage({super.key}) : super(chapter: ChapterEnum.environment);

  @override
  Widget buildContent(BuildContext context, Section section) {
    final environmentData = EnvironmentData.fromJson(section.data);

    return BaseDataCategoryPageScaffold(
      category: DataCategory.environment,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          EnvironmentSummaryGrid(summary: environmentData.summary),
          MilestoneTable(milestones: environmentData.energyPlanMilestones),
          CarbonFootprintTable(
            carbonFootprint: environmentData.carbonFootprint,
          ),
        ],
      ),
    );
  }
}
