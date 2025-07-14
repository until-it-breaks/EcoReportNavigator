import 'package:insightviewer/core/data_categories.dart';
import 'package:insightviewer/data/data_repository.dart';
import 'package:insightviewer/data/models/section.dart';
import 'package:insightviewer/data/models/sections/economic.dart';
import 'package:insightviewer/ui/pages/section_page.dart';
import 'package:insightviewer/ui/widgets/base_scaffold.dart';
import 'package:insightviewer/ui/widgets/economic/economic_detail_table.dart';
import 'package:insightviewer/ui/widgets/economic/economic_summary_grid.dart';
import 'package:insightviewer/ui/widgets/economic/green_purchases_card.dart';
import 'package:flutter/material.dart';

class EconomicPage extends SectionPage {
  const EconomicPage({super.key}) : super(chapter: ChapterEnum.economic);

  @override
  Widget buildContent(BuildContext context, Section section) {
    final economicData = EconomicData.fromJson(section.data);

    return BaseDataCategoryPageScaffold(
      category: DataCategory.economic,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          EconomicSummaryGrid(summary: economicData.summary),
          EconomicDetailTable(
            title: "Valore economico attratto",
            data: economicData.attractedDetailed,
            icon: Icons.arrow_downward,
          ),
          EconomicDetailTable(
            title: "Valore economico distribuito",
            data: economicData.distributedDetailed,
            icon: Icons.arrow_upward,
          ),
          GreenPurchasesCard(greenPurchases: economicData.greenPurchases),
        ],
      ),
    );
  }
}
