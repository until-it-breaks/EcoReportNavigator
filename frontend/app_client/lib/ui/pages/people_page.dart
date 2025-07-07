import 'package:app_client/data/data_repository.dart';
import 'package:app_client/data/models/section.dart';
import 'package:app_client/data/models/sections/people.dart';
import 'package:app_client/ui/pages/section_page.dart';
import 'package:app_client/ui/widgets/base_scaffold.dart';
import 'package:app_client/ui/widgets/people/academic_staff_bar_chart.dart';
import 'package:app_client/ui/widgets/people/administrative_staff_chart.dart';
import 'package:app_client/ui/widgets/people/people_summary_grid.dart';
import 'package:app_client/ui/widgets/people/remote_work_chart.dart';
import 'package:flutter/material.dart';

class PeoplePage extends SectionPage {
  const PeoplePage({super.key})
    : super(chapter: ChapterEnum.people, title: "Persone");

  @override
  Widget buildContent(BuildContext context, Section section) {
    final peopleData = PeopleData.fromJson(section.data);

    return BaseScaffold(
      title: title,
      body: Column(
        children: [
          PeopleSummaryGrid(summary: peopleData.summary),
          AcademicStaffBarChart(data: peopleData.academicStaffByRole),
          AdministrativeStaffBarChart(
            data: peopleData.administrativeStaffByYear,
          ),
          RemoteWorkBarChart(data: peopleData.remoteWorkStats),
        ],
      ),
    );
  }
}
