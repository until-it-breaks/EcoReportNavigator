import 'package:insightviewer/data/models/sections/society.dart';
import 'package:insightviewer/ui/widgets/summary_grid.dart';
import 'package:insightviewer/utility/utility.dart';
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
          label: "Borse di Studio Finanziate dall'Esterno",
          value: formatIntWithThousandsSeparator(
            summary.externallyFundedScholarships,
          ),
        ),
        SummaryItem(
          icon: Icons.event,
          label: "Eventi Promossi nel 2023",
          value: formatIntWithThousandsSeparator(summary.eventsPromotedIn2023),
        ),
        SummaryItem(
          icon: Icons.menu_book,
          label: "Patrimonio Documentario",
          value: formatIntWithThousandsSeparator(summary.documentaryHeritage),
        ),
        SummaryItem(
          icon: Icons.science,
          label: "Famiglie Brevettuali",
          value: formatIntWithThousandsSeparator(summary.patentFamilies),
        ),
        SummaryItem(
          icon: Icons.business,
          label: "Spin-off e Startup",
          value: formatIntWithThousandsSeparator(summary.spinOffsAndStartups),
        ),
        SummaryItem(
          icon: Icons.article,
          label: "Articoli ed Eventi da Unibo Magazine",
          value: formatIntWithThousandsSeparator(
            summary.magazineArticlesAndEvents,
          ),
        ),
        SummaryItem(
          icon: Icons.museum,
          label: "Visitatori Musei",
          value: formatIntWithThousandsSeparator(summary.museumVisitors),
        ),
        SummaryItem(
          icon: Icons.cast_for_education,
          label: "Corsi di Alta Formazione e Formazione Continua",
          value: formatIntWithThousandsSeparator(
            summary.advancedAndContinuingEducationCourses,
          ),
        ),
      ],
    );
  }
}
