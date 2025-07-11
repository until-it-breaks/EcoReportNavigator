import 'package:app_client/core/data_categories.dart';
import 'package:app_client/data/data_repository.dart';
import 'package:app_client/data/models/section.dart';
import 'package:app_client/data/models/sections/people.dart';
import 'package:app_client/ui/pages/section_page.dart';
import 'package:app_client/ui/widgets/base_scaffold.dart';
import 'package:app_client/ui/widgets/people/people_summary_grid.dart';
import 'package:app_client/ui/widgets/people/remote_work_chart.dart';
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
