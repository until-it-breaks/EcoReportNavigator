import 'package:app_client/data/models/sections/people.dart';
import 'package:app_client/ui/widgets/summary_grid.dart';
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
        value: summary.docenteRicercatore.value.toString(),
        percentageChange: summary.docenteRicercatore.percentageChange,
      ),
      SummaryItem(
        icon: Icons.people_alt,
        label: "Personale Tecnico-Amministrativo",
        value: summary.tecnicoAmministrativo.value.toString(),
        percentageChange: summary.tecnicoAmministrativo.percentageChange,
      ),
      SummaryItem(
        icon: Icons.access_time,
        label: "Ore di Formazione (2023)",
        value: summary.formazione2023.hours.toString(),
        percentageChange: summary.formazione2023.percentageChange,
      ),
      SummaryItem(
        icon: Icons.favorite,
        label: "Welfare per TA",
        value: "${summary.welfareTA.value} ${summary.welfareTA.unitOfMeasure}",
      ),
      SummaryItem(
        icon: Icons.laptop_mac,
        label: "Accordi di Smart Working",
        value: summary.smartWorkingAgreements.toString(),
      ),
      SummaryItem(
        icon: Icons.home_work,
        label: "Progetti di Telelavoro",
        value: summary.teleworkProjects.toString(),
      ),
    ];
    return SummaryGrid(items: entries);
  }
}
