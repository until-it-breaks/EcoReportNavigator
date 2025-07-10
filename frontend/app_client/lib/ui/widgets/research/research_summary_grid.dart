import 'package:app_client/data/models/sections/research.dart';
import 'package:app_client/ui/widgets/summary_grid.dart';
import 'package:flutter/material.dart';

class ResearchSummaryGrid extends StatelessWidget {
  final ResearchSummary summary;

  const ResearchSummaryGrid({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    return SummaryGrid(
      items: [
        SummaryItem(
          icon: Icons.science,
          label: "Progetti Horizon Europe",
          value: summary.horizonEuropeProjects.toString(),
        ),
        SummaryItem(
          icon: Icons.school,
          label: "Assegni di Ricerca",
          value: summary.researchGrants.toString(),
        ),
        SummaryItem(
          icon: Icons.flight_takeoff,
          label: "Docenti Outgoing",
          value: summary.outgoingProfessors.toString(),
        ),
        SummaryItem(
          icon: Icons.monetization_on,
          label: "PNRR e PNC",
          value:
              "${summary.cascadeFundingPnrrPnc.value} ${summary.cascadeFundingPnrrPnc.unit}",
        ),
        SummaryItem(
          icon: Icons.menu_book,
          label: "Pubblicazioni",
          value: summary.publications.toString(),
        ),
        SummaryItem(
          icon: Icons.people_alt,
          label: "Visiting Professors e PhD",
          value: summary.visitingProfessorsAndPhd.toString(),
        ),
      ],
    );
  }
}
