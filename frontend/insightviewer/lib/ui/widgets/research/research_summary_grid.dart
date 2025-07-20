import 'package:insightviewer/data/models/topics/reseach/research_summary.dart';
import 'package:insightviewer/ui/widgets/summary_grid.dart';
import 'package:insightviewer/utility/utility.dart';
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
          value: formatIntWithThousandsSeparator(summary.horizonEuropeProjects),
        ),
        SummaryItem(
          icon: Icons.school,
          label: "Assegni di Ricerca",
          value: formatIntWithThousandsSeparator(summary.researchGrants),
        ),
        SummaryItem(
          icon: Icons.flight_takeoff,
          label: "Docenti Outgoing",
          value: formatIntWithThousandsSeparator(summary.outgoingProfessors),
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
          value: formatIntWithThousandsSeparator(summary.publications),
        ),
        SummaryItem(
          icon: Icons.people_alt,
          label: "Visiting Professors e PhD",
          value: formatIntWithThousandsSeparator(
            summary.visitingProfessorsAndPhd,
          ),
        ),
      ],
    );
  }
}
