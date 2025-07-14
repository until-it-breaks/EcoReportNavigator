import 'package:insightviewer/core/data_categories.dart';
import 'package:insightviewer/data/data_repository.dart';
import 'package:insightviewer/data/models/section.dart';
import 'package:insightviewer/data/models/sections/research.dart';
import 'package:insightviewer/ui/pages/section_page.dart';
import 'package:insightviewer/ui/widgets/base_scaffold.dart';
import 'package:insightviewer/ui/widgets/research/pnrr_pie_chart.dart';
import 'package:insightviewer/ui/widgets/research/research_summary_grid.dart';
import 'package:flutter/material.dart';

class ResearchPage extends SectionPage {
  const ResearchPage({super.key}) : super(chapter: ChapterEnum.research);

  @override
  Widget buildContent(BuildContext context, Section section) {
    final researchData = ResearchData.fromJson(section.data);

    return BaseDataCategoryPageScaffold(
      category: DataCategory.research,
      body: Column(
        spacing: 12,
        children: [
          ResearchSummaryGrid(summary: researchData.researchSummary),
          PnrrPieChart(data: researchData.pnrr),
        ],
      ),
    );
  }
}
