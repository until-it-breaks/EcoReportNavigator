import 'package:app_client/data/data_repository.dart';
import 'package:app_client/data/models/section.dart';
import 'package:app_client/data/models/sections/research.dart';
import 'package:app_client/ui/pages/section_page.dart';
import 'package:app_client/ui/widgets/base_scaffold.dart';
import 'package:app_client/ui/widgets/research/pnrr_pie_chart.dart';
import 'package:app_client/ui/widgets/research/research_summary_grid.dart';
import 'package:flutter/cupertino.dart';

class ResearchPage extends SectionPage {
  const ResearchPage({super.key})
    : super(chapter: ChapterEnum.research, title: "Ricerca");

  @override
  Widget buildContent(BuildContext context, Section section) {
    final researchData = ResearchData.fromJson(section.data);

    return BaseScaffold(
      title: title,
      body: Column(
        children: [
          ResearchSummaryGrid(summary: researchData.researchSummary),
          PnrrPieChart(data: researchData.pnrr),
        ],
      ),
    );
  }
}
