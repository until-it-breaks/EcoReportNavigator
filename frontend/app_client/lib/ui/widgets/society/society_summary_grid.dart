import 'package:app_client/data/models/sections/society.dart';
import 'package:app_client/ui/widgets/summary_grid.dart';
import 'package:flutter/material.dart';

class SocietySummaryGrid extends StatelessWidget {
  final SocietySummary summary;

  const SocietySummaryGrid({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    return SummaryGrid(
      items: [
        SummaryItem(
          icon: Icons.school,
          label: "Borse di Studio Finanziate Esternamente",
          value: summary.externallyFundedScholarships.toString(),
        ),
        SummaryItem(
          icon: Icons.event,
          label: "Eventi Promossi (2023)",
          value: summary.eventsPromotedIn2023.toString(),
        ),
        SummaryItem(
          icon: Icons.menu_book,
          label: "Patrimonio Documentario",
          value: summary.documentaryHeritage.toString(),
        ),
        SummaryItem(
          icon: Icons.science,
          label: "Famiglie Brevettuali",
          value: summary.patentFamilies.toString(),
        ),
        SummaryItem(
          icon: Icons.business,
          label: "Spin-off e Startup",
          value: summary.spinOffsAndStartups.toString(),
        ),
        SummaryItem(
          icon: Icons.article,
          label: "Articoli ed Eventi Magazine",
          value: summary.magazineArticlesAndEvents.toString(),
        ),
        SummaryItem(
          icon: Icons.museum,
          label: "Visitatori Musei",
          value: summary.museumVisitors.toString(),
        ),
        SummaryItem(
          icon: Icons.cast_for_education,
          label: "Corsi Alta/Formazione Continua",
          value: summary.advancedAndContinuingEducationCourses.toString(),
        ),
      ],
    );
  }
}
