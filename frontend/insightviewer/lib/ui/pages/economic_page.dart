import 'package:insightviewer/core/app_chapter.dart';
import 'package:insightviewer/core/topic_keys.dart';
import 'package:insightviewer/data/data_repository.dart';
import 'package:insightviewer/data/models/topics/economic/economic_value_detailed.dart';
import 'package:insightviewer/data/models/topics/economic/economic_value_summary.dart';
import 'package:insightviewer/data/models/topics/economic/green_purchases.dart';
import 'package:insightviewer/ui/pages/chapter_page.dart';
import 'package:insightviewer/ui/widgets/economic/economic_detail_table.dart';
import 'package:insightviewer/ui/widgets/economic/economic_summary_grid.dart';
import 'package:insightviewer/ui/widgets/economic/green_purchases_card.dart';
import 'package:flutter/material.dart';

class EconomicPage extends StatelessWidget {
  const EconomicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChapterPage<_EconomicTopics>(
      chapter: AppChapter.economic,
      fetcher: _fetchEconomicTopics,
      builder: (context, data) {
        final summary = data.summary;
        final attracted = data.attracted;
        final distributed = data.distributed;
        final greenPurchases = data.greenPurchases;

        return Column(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (summary != null) EconomicSummaryGrid(summary: summary),
            if (attracted != null)
              EconomicDetailTable(
                title: "Valore economico attratto",
                data: attracted,
                icon: Icons.arrow_downward,
              ),
            if (distributed != null)
              EconomicDetailTable(
                title: "Valore economico distribuito",
                data: distributed,
                icon: Icons.arrow_upward,
              ),
            if (greenPurchases != null)
              GreenPurchasesCard(greenPurchases: greenPurchases),
          ],
        );
      },
    );
  }
}

Future<_EconomicTopics> _fetchEconomicTopics(int chapterId) async {
  final repo = DataRepository();

  final summaryFuture = repo.fetchTopic(
    AppChapter.economic,
    EconomicTopicsKeys.summary,
  );

  final attractedFuture = repo.fetchTopic(
    AppChapter.economic,
    EconomicTopicsKeys.attracted,
  );

  final distributedFuture = repo.fetchTopic(
    AppChapter.economic,
    EconomicTopicsKeys.distributed,
  );

  final greenPurchasesFuture = repo.fetchTopic(
    AppChapter.economic,
    EconomicTopicsKeys.greenPurchases,
  );

  EconomicValueSummary? summary;
  EconomicValueDetailed? attracted;
  EconomicValueDetailed? distributed;
  GreenPurchases? greenPurchases;

  try {
    final topic = await summaryFuture;
    summary = EconomicValueSummary.fromJson(topic.data);
  } catch (e, st) {
    debugPrint('Error loading [${EconomicTopicsKeys.summary}]: $e\n$st');
  }

  try {
    final topic = await attractedFuture;
    attracted = EconomicValueDetailed.fromJson(topic.data);
  } catch (e, st) {
    debugPrint('Error loading [${EconomicTopicsKeys.attracted}]: $e\n$st');
  }

  try {
    final topic = await distributedFuture;
    distributed = EconomicValueDetailed.fromJson(topic.data);
  } catch (e, st) {
    debugPrint('Error loading [${EconomicTopicsKeys.distributed}]: $e\n$st');
  }

  try {
    final topic = await greenPurchasesFuture;
    greenPurchases = GreenPurchases.fromJson(topic.data);
  } catch (e, st) {
    debugPrint('Error loading [${EconomicTopicsKeys.greenPurchases}]: $e\n$st');
  }

  return _EconomicTopics(
    summary: summary,
    attracted: attracted,
    distributed: distributed,
    greenPurchases: greenPurchases,
  );
}

class _EconomicTopics {
  final EconomicValueSummary? summary;
  final EconomicValueDetailed? attracted;
  final EconomicValueDetailed? distributed;
  final GreenPurchases? greenPurchases;

  _EconomicTopics({
    required this.summary,
    required this.attracted,
    required this.distributed,
    required this.greenPurchases,
  });
}
