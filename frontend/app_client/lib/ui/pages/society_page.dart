import 'package:app_client/core/data_categories.dart';
import 'package:app_client/data/data_repository.dart';
import 'package:app_client/data/models/section.dart';
import 'package:app_client/data/models/sections/society.dart';
import 'package:app_client/ui/pages/section_page.dart';
import 'package:app_client/ui/widgets/base_scaffold.dart';
import 'package:app_client/ui/widgets/society/internship_agreements_pie_chart.dart';
import 'package:app_client/ui/widgets/society/social_events_list.dart';
import 'package:app_client/ui/widgets/society/social_networks_table.dart';
import 'package:app_client/ui/widgets/society/society_summary_grid.dart';
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
          SocialEventList(data: societyData.events),
          SocialChannelsTable(data: societyData.socialChannels),
        ],
      ),
    );
  }
}
