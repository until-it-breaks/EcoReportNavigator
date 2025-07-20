import 'package:insightviewer/core/app_chapter.dart';
import 'package:insightviewer/core/topic_keys.dart';
import 'package:insightviewer/data/data_repository.dart';
import 'package:insightviewer/data/models/topics/society/internship_agreements_data.dart';
import 'package:insightviewer/data/models/topics/society/social_event.dart';
import 'package:insightviewer/data/models/topics/society/society_summary.dart';
import 'package:insightviewer/ui/pages/chapter_page.dart';
import 'package:insightviewer/ui/widgets/society/internship_agreements_pie_chart.dart';
import 'package:insightviewer/ui/widgets/society/social_events_list.dart';
import 'package:insightviewer/ui/widgets/society/society_summary_grid.dart';
import 'package:flutter/material.dart';

class SocietyPage extends StatelessWidget {
  const SocietyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChapterPage<_SocietyTopics>(
      chapter: AppChapter.society,
      fetcher: _fetchSocietyTopics,
      builder: (context, data) {
        final summary = data.societySummary;
        final internship = data.internshipAgreements;
        final events = data.socialEvents;

        return Column(
          spacing: 12,
          children: [
            if (summary != null) SocietySummaryGrid(summary: summary),
            if (internship != null)
              InternshipAgreementsPieChart(data: internship),
            if (events != null && events.isNotEmpty)
              SocialEventList(events: events),
          ],
        );
      },
    );
  }
}

Future<_SocietyTopics> _fetchSocietyTopics(int chapterId) async {
  final repo = DataRepository();

  final summaryFuture = repo.fetchTopic(
    AppChapter.society,
    SocietyTopicsKeys.summary,
  );

  final internshipFuture = repo.fetchTopic(
    AppChapter.society,
    SocietyTopicsKeys.internshipAgreements,
  );

  final eventsFuture = repo.fetchTopic(
    AppChapter.society,
    SocietyTopicsKeys.socialEvents,
  );

  SocietySummary? societySummary;
  InternshipAgreementsData? internshipAgreements;
  List<SocialEvent>? socialEvents;

  try {
    final topic = await summaryFuture;
    societySummary = SocietySummary.fromJson(topic.data);
  } catch (e, st) {
    debugPrint('Error loading [${SocietyTopicsKeys.summary}]: $e\n$st');
  }

  try {
    final topic = await internshipFuture;
    internshipAgreements = InternshipAgreementsData.fromJson(topic.data);
  } catch (e, st) {
    debugPrint(
      'Error loading [${SocietyTopicsKeys.internshipAgreements}]: $e\n$st',
    );
  }

  try {
    final topic = await eventsFuture;
    socialEvents = SocialEvent.listFromJson(
      topic.data["dati"] as List<dynamic>,
    );
  } catch (e, st) {
    debugPrint('Error loading [${SocietyTopicsKeys.socialEvents}]: $e\n$st');
  }

  return _SocietyTopics(
    societySummary: societySummary,
    internshipAgreements: internshipAgreements,
    socialEvents: socialEvents,
  );
}

class _SocietyTopics {
  final SocietySummary? societySummary;
  final InternshipAgreementsData? internshipAgreements;
  final List<SocialEvent>? socialEvents;

  _SocietyTopics({
    required this.societySummary,
    required this.internshipAgreements,
    required this.socialEvents,
  });
}
