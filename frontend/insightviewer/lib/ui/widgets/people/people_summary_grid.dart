import 'package:insightviewer/data/models/topics/people/people_summary.dart';
import 'package:insightviewer/ui/widgets/summary_grid.dart';
import 'package:insightviewer/utility/utility.dart';
import 'package:flutter/material.dart';

class PeopleSummaryGrid extends StatelessWidget {
  final PeopleSummary summary;

  const PeopleSummaryGrid({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    final entries = [
      SummaryItem(
        icon: Icons.school,
        label: "Personale Docente e Ricercatore",
        value: formatIntWithThousandsSeparator(
          summary.docenteRicercatore.value,
        ),
        percentageChange: summary.docenteRicercatore.percentageChange,
      ),
      SummaryItem(
        icon: Icons.people_alt,
        label: "Personale Tecnico-Amministrativo",
        value: formatIntWithThousandsSeparator(
          summary.tecnicoAmministrativo.value,
        ),
        percentageChange: summary.tecnicoAmministrativo.percentageChange,
      ),
      SummaryItem(
        icon: Icons.access_time,
        label: "Ore di Formazione (2023)",
        value: formatIntWithThousandsSeparator(summary.formazione2023.hours),
        percentageChange: summary.formazione2023.percentageChange,
      ),
      SummaryItem(
        icon: Icons.favorite,
        label: "Welfare per TA",
        value: formatValueWithUnitWithThousandsSeparator(summary.welfareTA),
      ),
      SummaryItem(
        icon: Icons.laptop_mac,
        label: "Accordi di Smart Working",
        value: formatIntWithThousandsSeparator(summary.smartWorkingAgreements),
      ),
      SummaryItem(
        icon: Icons.home_work,
        label: "Progetti di Telelavoro",
        value: formatIntWithThousandsSeparator(summary.teleworkProjects),
      ),
    ];
    return SummaryGrid(items: entries);
  }
}
