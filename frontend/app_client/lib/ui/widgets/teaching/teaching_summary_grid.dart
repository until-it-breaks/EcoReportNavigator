import 'package:app_client/data/models/sections/teaching.dart';
import 'package:app_client/ui/widgets/summary_grid.dart';
import 'package:app_client/utility/utility.dart';
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
          value: formatIntWithThousandsSeparator(summary.courseCount),
        ),
        SummaryItem(
          icon: Icons.people,
          label: "Studenti Iscritti (2023)",
          value: formatIntWithThousandsSeparator(summary.enrolledStudents2023),
        ),
        SummaryItem(
          icon: Icons.public,
          label: "Studenti Internazionali",
          value: formatIntWithThousandsSeparator(summary.internationalStudents),
        ),
        SummaryItem(
          icon: Icons.workspace_premium,
          label: "Numero Laureati",
          value: formatIntWithThousandsSeparator(summary.numberOfGraduates),
        ),
        SummaryItem(
          icon: Icons.card_giftcard,
          label: "Borse ER.GO",
          value: formatIntWithThousandsSeparator(summary.ergoScholarships),
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
