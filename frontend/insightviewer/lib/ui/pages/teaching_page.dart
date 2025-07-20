import 'package:insightviewer/core/app_chapter.dart';
import 'package:insightviewer/core/topic_keys.dart';
import 'package:insightviewer/data/data_repository.dart';
import 'package:insightviewer/data/models/topics/teaching/active_course.dart';
import 'package:insightviewer/data/models/topics/teaching/gender_composition.dart';
import 'package:insightviewer/data/models/topics/teaching/teaching_summary.dart';
import 'package:insightviewer/ui/pages/chapter_page.dart';
import 'package:insightviewer/ui/widgets/teaching/active_courses_bar_chart.dart';
import 'package:insightviewer/ui/widgets/teaching/gender_enrollment_chart.dart';
import 'package:insightviewer/ui/widgets/teaching/teaching_summary_grid.dart';
import 'package:flutter/material.dart';

class TeachingPage extends StatelessWidget {
  const TeachingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChapterPage<_TeachingTopics>(
      chapter: AppChapter.teaching,
      fetcher: _fetchTeachingTopics,
      builder: (context, data) {
        final summary = data.summary;
        final activeCourses = data.activeCourses;
        final enrollmentByGender = data.enrollmentByGender;

        return Column(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (summary != null) TeachingSummaryGrid(summary: summary),
            if (activeCourses != null)
              ActiveCoursesBarChart(activeCourses: activeCourses),
            if (enrollmentByGender != null)
              GenderPieCharts(enrollmentByGender: enrollmentByGender),
          ],
        );
      },
    );
  }
}

Future<_TeachingTopics> _fetchTeachingTopics(int chapterId) async {
  final repo = DataRepository();

  final summaryFuture = repo.fetchTopic(
    AppChapter.teaching,
    TeachingTopicsKeys.summary,
  );

  final coursesFuture = repo.fetchTopic(
    AppChapter.teaching,
    TeachingTopicsKeys.activeCourses,
  );

  final genderFuture = repo.fetchTopic(
    AppChapter.teaching,
    TeachingTopicsKeys.enrollmentByGender,
  );

  TeachingSummary? summary;
  List<ActiveCourse>? activeCourses;
  EnrollmentByGender? enrollmentByGender;

  try {
    final topic = await summaryFuture;
    summary = TeachingSummary.fromJson(topic.data);
  } catch (e, st) {
    debugPrint('Error loading [${TeachingTopicsKeys.summary}]: $e\n$st');
  }

  try {
    final topic = await coursesFuture;
    activeCourses = ActiveCourse.listFromJson(
      topic.data["dati"] as List<dynamic>,
    );
  } catch (e, st) {
    debugPrint('Error loading [${TeachingTopicsKeys.activeCourses}]: $e\n$st');
  }

  try {
    final topic = await genderFuture;
    enrollmentByGender = EnrollmentByGender.fromJson(topic.data);
  } catch (e, st) {
    debugPrint(
      'Error loading [${TeachingTopicsKeys.enrollmentByGender}]: $e\n$st',
    );
  }

  return _TeachingTopics(
    summary: summary,
    activeCourses: activeCourses,
    enrollmentByGender: enrollmentByGender,
  );
}

class _TeachingTopics {
  final TeachingSummary? summary;
  final List<ActiveCourse>? activeCourses;
  final EnrollmentByGender? enrollmentByGender;

  _TeachingTopics({
    required this.summary,
    required this.activeCourses,
    required this.enrollmentByGender,
  });
}
