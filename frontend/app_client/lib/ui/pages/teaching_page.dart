import 'package:app_client/core/data_categories.dart';
import 'package:app_client/data/data_repository.dart';
import 'package:app_client/data/models/section.dart';
import 'package:app_client/data/models/sections/teaching.dart';
import 'package:app_client/ui/pages/section_page.dart';
import 'package:app_client/ui/widgets/base_scaffold.dart';
import 'package:app_client/ui/widgets/teaching/active_courses_bar_chart.dart';
import 'package:app_client/ui/widgets/teaching/gender_enrollment_chart.dart';
import 'package:app_client/ui/widgets/teaching/teaching_summary_grid.dart';
import 'package:flutter/material.dart';

class TeachingPage extends SectionPage {
  const TeachingPage({super.key}) : super(chapter: ChapterEnum.teaching);

  @override
  Widget buildContent(BuildContext context, Section section) {
    final teachingData = TeachingData.fromJson(section.data);

    return BaseDataCategoryPageScaffold(
      category: DataCategory.teaching,
      body: Column(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TeachingSummaryGrid(summary: teachingData.summary),
          ActiveCoursesBarChart(activeCourses: teachingData.activeCourses),
          GenderPieCharts(enrollmentByGender: teachingData.enrollmentByGender),
        ],
      ),
    );
  }
}
