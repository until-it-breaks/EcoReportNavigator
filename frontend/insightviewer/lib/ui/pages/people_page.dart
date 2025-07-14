import 'package:insightviewer/core/data_categories.dart';
import 'package:insightviewer/data/data_repository.dart';
import 'package:insightviewer/data/models/section.dart';
import 'package:insightviewer/data/models/sections/people.dart';
import 'package:insightviewer/ui/pages/section_page.dart';
import 'package:insightviewer/ui/widgets/base_scaffold.dart';
import 'package:insightviewer/ui/widgets/people/people_summary_grid.dart';
import 'package:insightviewer/ui/widgets/people/remote_work_chart.dart';
import 'package:flutter/material.dart';

class PeoplePage extends SectionPage {
  const PeoplePage({super.key}) : super(chapter: ChapterEnum.people);

  @override
  Widget buildContent(BuildContext context, Section section) {
    final peopleData = PeopleData.fromJson(section.data);

    return BaseDataCategoryPageScaffold(
      category: DataCategory.people,
      body: Column(
        spacing: 12,
        children: [
          PeopleSummaryGrid(summary: peopleData.summary),
          RemoteWorkBarChart(data: peopleData.remoteWorkStats),
        ],
      ),
    );
  }
}
