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
  const EconomicPage({super.key})
    : super(chapter: ChapterEnum.economic, title: "Valore Economico");

  @override
  Widget buildContent(BuildContext context, Section section) {
    final economicData = EconomicData.fromJson(section.data);

    return BaseScaffold(
      title: title,
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
