import 'package:app_client/data/models/sections/teaching.dart';
import 'package:app_client/ui/widgets/summary_grid.dart';
import 'package:flutter/material.dart';

class TeachingSummaryGrid extends StatelessWidget {
  final TeachingSummary summary;

  const TeachingSummaryGrid({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    return SummaryGrid(
      items: [
        SummaryItem(
          icon: Icons.school,
          label: "Corsi di Studio",
          value: summary.courseCount.toString(),
        ),
        SummaryItem(
          icon: Icons.people,
          label: "Studenti Iscritti (2023)",
          value: summary.enrolledStudents2023.toString(),
        ),
        SummaryItem(
          icon: Icons.public,
          label: "Studenti Internazionali",
          value: summary.internationalStudents.toString(),
        ),
        SummaryItem(
          icon: Icons.workspace_premium,
          label: "Numero Laureati",
          value: summary.numberOfGraduates.toString(),
        ),
        SummaryItem(
          icon: Icons.card_giftcard,
          label: "Borse ER.GO",
          value: summary.ergoScholarships.toString(),
        ),
        SummaryItem(
          icon: Icons.timelapse,
          label: "Iscritti in Corso",
          value: summary.onTimeEnrolledPercentage.toString(),
          percentageChange: null,
        ),
      ],
    );
  }
}
