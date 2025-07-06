import 'package:app_client/data/data_repository.dart';
import 'package:app_client/data/models/section.dart';
import 'package:app_client/ui/pages/section_page.dart';
import 'package:app_client/ui/widgets/base_scaffold.dart';
import 'package:flutter/cupertino.dart';

class ResearchPage extends SectionPage {
  const ResearchPage({super.key})
    : super(chapter: ChapterEnum.research, title: "Ricerca");

  @override
  Widget buildContent(BuildContext context, Section section) {
    final researchData = DataRepository().fetchSection(ChapterEnum.research);

    return BaseScaffold(
      title: title,
      body: Column(children: [Text("Ricerca")]),
    );
  }
}
