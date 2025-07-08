import 'package:app_client/core/data_categories.dart';
import 'package:app_client/data/data_repository.dart';
import 'package:app_client/data/models/section.dart';
import 'package:app_client/data/models/sections/economic.dart';
import 'package:app_client/ui/pages/section_page.dart';
import 'package:app_client/ui/widgets/base_scaffold.dart';
import 'package:app_client/ui/widgets/economic/economic_detail_table.dart';
import 'package:app_client/ui/widgets/economic/economic_summary_grid.dart';
import 'package:app_client/ui/widgets/economic/green_purchases_card.dart';
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
        children: [
          EconomicSummaryGrid(summary: economicData.summary),
          EconomicDetailTable(
            title: "Valore economico attratto",
            data: economicData.attractedDetailed,
          ),
          EconomicDetailTable(
            title: "Valore economico distribuito",
            data: economicData.distributedDetailed,
          ),
          GreenPurchasesCard(data: economicData.greenPurchases),
        ],
      ),
    );
  }
}
