import 'package:app_client/data/data_repository.dart';
import 'package:app_client/data/models/section.dart';
import 'package:app_client/ui/pages/section_page.dart';
import 'package:app_client/ui/widgets/base_scaffold.dart';
import 'package:flutter/material.dart';

class SocietyPage extends SectionPage {
  const SocietyPage({super.key})
    : super(chapter: ChapterEnum.society, title: "Società");

  @override
  Widget buildContent(BuildContext context, Section section) {
    final societyData = DataRepository().fetchSection(ChapterEnum.society);

    return BaseScaffold(
      title: title,
      body: Column(children: [Text("Società")]),
    );
  }
}
