import 'package:insightviewer/core/app_chapter.dart';
import 'package:insightviewer/core/topic_keys.dart';
import 'package:insightviewer/data/data_repository.dart';
import 'package:insightviewer/data/models/topics/reseach/pnrr.dart';
import 'package:insightviewer/data/models/topics/reseach/research_summary.dart';
import 'package:insightviewer/ui/pages/chapter_page.dart';
import 'package:insightviewer/ui/widgets/research/pnrr_pie_chart.dart';
import 'package:insightviewer/ui/widgets/research/research_summary_grid.dart';
import 'package:flutter/material.dart';

class ResearchPage extends StatelessWidget {
  const ResearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChapterPage<_ResearchTopics>(
      chapter: AppChapter.research,
      fetcher: _fetchResearchTopics,
      builder: (context, data) {
        final summary = data.summary;
        final pnrr = data.pnrr;

        return Column(
          spacing: 12,
          children: [
            if (summary != null) ResearchSummaryGrid(summary: summary),
            if (pnrr != null) PnrrPieChart(data: pnrr),
          ],
        );
      },
    );
  }
}

Future<_ResearchTopics> _fetchResearchTopics(int chapterId) async {
  final repo = DataRepository();

  final summaryFuture = repo.fetchTopic(
    AppChapter.research,
    ResearchTopicsKeys.summary,
  );

  final pnrrFuture = repo.fetchTopic(
    AppChapter.research,
    ResearchTopicsKeys.pnrr,
  );

  ResearchSummary? summary;
  Pnrr? pnrr;

  try {
    final topic = await summaryFuture;
    summary = ResearchSummary.fromJson(topic.data);
  } catch (e, st) {
    debugPrint('Error loading [${ResearchTopicsKeys.summary}]: $e\n$st');
  }

  try {
    final topic = await pnrrFuture;
    pnrr = Pnrr.fromJson(topic.data);
  } catch (e, st) {
    debugPrint('Error loading [${ResearchTopicsKeys.pnrr}]: $e\n$st');
  }

  return _ResearchTopics(summary: summary, pnrr: pnrr);
}

class _ResearchTopics {
  final ResearchSummary? summary;
  final Pnrr? pnrr;

  _ResearchTopics({required this.summary, required this.pnrr});
}
