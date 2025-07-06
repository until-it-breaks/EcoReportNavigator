import 'package:app_client/data/data_repository.dart';
import 'package:app_client/data/models/section.dart';
import 'package:app_client/ui/pages/section_page.dart';
import 'package:app_client/ui/widgets/base_scaffold.dart';
import 'package:flutter/material.dart';

class EnvironmentPage extends SectionPage {
  const EnvironmentPage({super.key})
    : super(chapter: ChapterEnum.society, title: "Ambiente");

  @override
  Widget buildContent(BuildContext context, Section section) {
    final environmentData = DataRepository().fetchSection(
      ChapterEnum.environment,
    );

    return BaseScaffold(
      title: title,
      body: Column(children: [Text("Ambiente")]),
    );
  }
}
