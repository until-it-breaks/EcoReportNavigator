import 'package:app_client/data/data_repository.dart';
import 'package:app_client/data/models/section.dart';
import 'package:app_client/data/models/sections/environment.dart';
import 'package:app_client/ui/pages/section_page.dart';
import 'package:app_client/ui/widgets/base_scaffold.dart';
import 'package:app_client/ui/widgets/environment/environment_summary_grid.dart';
import 'package:flutter/material.dart';

class EnvironmentPage extends SectionPage {
  const EnvironmentPage({super.key})
    : super(chapter: ChapterEnum.environment, title: "Ambiente");

  @override
  Widget buildContent(BuildContext context, Section section) {
    final environmentData = EnvironmentData.fromJson(section.data);

    return BaseScaffold(
      title: title,
      body: Column(
        children: [EnvironmentSummaryGrid(summary: environmentData.summary)],
      ),
    );
  }
}
