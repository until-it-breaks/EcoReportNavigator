import 'package:app_client/data/data_repository.dart';
import 'package:app_client/data/models/section.dart';
import 'package:app_client/data/models/sections/economic.dart';
import 'package:app_client/ui/widgets/base_scaffold.dart';
import 'package:app_client/ui/widgets/economic/economic_detail_table.dart';
import 'package:app_client/ui/widgets/economic/economic_summary_grid.dart';
import 'package:app_client/ui/widgets/economic/green_purchases_card.dart';
import 'package:flutter/material.dart';

class EconomicPage extends StatefulWidget {
  const EconomicPage({super.key});

  @override
  State<EconomicPage> createState() => _EconomicPageState();
}

class _EconomicPageState extends State<EconomicPage> {
  late Future<Section> _futureSection;

  @override
  void initState() {
    super.initState();
    _futureSection = DataRepository().fetchSection(ChapterEnum.economic);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Section>(
      future: _futureSection,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text("Errore: ${snapshot.error}")),
          );
        }
        final section = snapshot.data;
        if (section == null) {
          return const Scaffold(body: Center(child: Text("No data found")));
        }
        final economicData = EconomicData.fromJson(section.data);
        return BaseScaffold(
          title: "Valore Economico",
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
      },
    );
  }
}
