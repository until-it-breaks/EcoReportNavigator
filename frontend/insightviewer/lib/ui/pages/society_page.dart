import 'package:insightviewer/core/data_categories.dart';
import 'package:insightviewer/data/data_repository.dart';
import 'package:insightviewer/data/models/section.dart';
import 'package:insightviewer/data/models/sections/society.dart';
import 'package:insightviewer/ui/pages/section_page.dart';
import 'package:insightviewer/ui/widgets/base_scaffold.dart';
import 'package:insightviewer/ui/widgets/society/internship_agreements_pie_chart.dart';
import 'package:insightviewer/ui/widgets/society/social_events_list.dart';
import 'package:insightviewer/ui/widgets/society/society_summary_grid.dart';
import 'package:flutter/material.dart';

class SocietyPage extends SectionPage {
  const SocietyPage({super.key}) : super(chapter: ChapterEnum.society);

  @override
  Widget buildContent(BuildContext context, Section section) {
    final societyData = SocietyData.fromJson(section.data);
    return BaseDataCategoryPageScaffold(
      category: DataCategory.society,
      body: Column(
        spacing: 12,
        children: [
          SocietySummaryGrid(summary: societyData.societySummary),
          InternshipAgreementsPieChart(data: societyData.internshipAgreements),
          SocialEventList(events: societyData.socialEvents),
        ],
      ),
    );
  }
}
