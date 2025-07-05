import 'package:app_client/data/data_repository.dart';
import 'package:app_client/models/section.dart';
import 'package:app_client/models/sections/teaching.dart';
import 'package:app_client/widgets/base_scaffold.dart';
import 'package:app_client/widgets/teaching/active_courses_bar_chart.dart';
import 'package:app_client/widgets/teaching/teaching_summary_grid.dart';
import 'package:flutter/material.dart';

class TeachingPage extends StatefulWidget {
  const TeachingPage({super.key});

  @override
  State<StatefulWidget> createState() => _TeachingPageState();
}

class _TeachingPageState extends State<TeachingPage> {
  late Future<Section> _futureSection;

  @override
  void initState() {
    super.initState();
    _futureSection = DataRepository().fetchTeachingSection();
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
        final teachingData = TeachingData.fromJson(section.data);
        return BaseScaffold(
          title: "Didattica",
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TeachingSummaryGrid(summary: teachingData.summary),
              ActiveCoursesBarChart(activeCourses: teachingData.activeCourses),
            ],
          ),
        );
      },
    );
  }
}
