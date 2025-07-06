import 'package:app_client/data/data_repository.dart';
import 'package:app_client/data/models/section.dart';
import 'package:flutter/material.dart';

abstract class SectionPage extends StatefulWidget {
  final ChapterEnum chapter;
  final String title;

  const SectionPage({super.key, required this.chapter, required this.title});

  Widget buildContent(BuildContext context, Section section);

  @override
  State<SectionPage> createState() => _SectionPageState();
}

class _SectionPageState extends State<SectionPage> {
  late Future<Section> _futureSection;

  @override
  void initState() {
    super.initState();
    _futureSection = DataRepository().fetchSection(widget.chapter);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
          return const Scaffold(
            body: Center(child: Text("Nessun dato trovato")),
          );
        }
        return widget.buildContent(context, section);
      },
    );
  }
}
