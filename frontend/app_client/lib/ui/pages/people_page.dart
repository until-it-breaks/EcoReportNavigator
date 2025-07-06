import 'package:app_client/data/data_repository.dart';
import 'package:app_client/data/models/section.dart';
import 'package:app_client/ui/pages/section_page.dart';
import 'package:app_client/ui/widgets/base_scaffold.dart';
import 'package:flutter/material.dart';

class PeoplePage extends SectionPage {
  const PeoplePage({super.key})
    : super(chapter: ChapterEnum.people, title: "Persone");

  @override
  Widget buildContent(BuildContext context, Section section) {
    final peopleData = DataRepository().fetchSection(ChapterEnum.people);

    return BaseScaffold(
      title: title,
      body: Column(children: [Text("Persone")]),
    );
  }
}
