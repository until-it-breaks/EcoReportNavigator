import 'package:insightviewer/core/app_chapter.dart';
import 'package:insightviewer/core/topic_keys.dart';
import 'package:insightviewer/data/data_repository.dart';
import 'package:insightviewer/data/models/topics/people/people_summary.dart';
import 'package:insightviewer/ui/pages/chapter_page.dart';
import 'package:flutter/material.dart';
import 'package:insightviewer/ui/widgets/people/people_summary_grid.dart';

class PeoplePage extends StatelessWidget {
  const PeoplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChapterPage<_PeopleTopicData>(
      chapter: AppChapter.people,
      fetcher: _fetchPeopleTopics,
      builder: (context, data) {
        final summary = data.summary;

        return Column(
          spacing: 12,
          children: [if (summary != null) PeopleSummaryGrid(summary: summary)],
        );
      },
    );
  }
}

Future<_PeopleTopicData> _fetchPeopleTopics(int chapterId) async {
  final repository = DataRepository();

  PeopleSummary? summary;
  try {
    final topic = await repository.fetchTopic(
      AppChapter.people,
      PeopleTopicsKeys.summary,
    );
    summary = PeopleSummary.fromJson(topic.data);
  } catch (e, st) {
    debugPrint('Error loading [${PeopleTopicsKeys.summary}]: $e\n$st');
  }

  return _PeopleTopicData(summary: summary);
}

class _PeopleTopicData {
  final PeopleSummary? summary;

  _PeopleTopicData({required this.summary});
}
