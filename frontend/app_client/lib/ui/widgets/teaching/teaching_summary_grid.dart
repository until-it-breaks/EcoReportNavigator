import 'package:app_client/data/models/sections/teaching.dart';
import 'package:flutter/material.dart';

class TeachingSummaryGrid extends StatelessWidget {
  final TeachingSummary summary;

  const TeachingSummaryGrid({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    final entries = [
      _SummaryItem(
        icon: Icons.school,
        label: "Corsi di Studio",
        value: summary.courseCount.toString(),
      ),
      _SummaryItem(
        icon: Icons.people,
        label: "Studenti Iscritti (2023)",
        value: summary.enrolledStudents2023.toString(),
      ),
      _SummaryItem(
        icon: Icons.public,
        label: "Studenti Internazionali",
        value: summary.internationalStudents.toString(),
      ),
      _SummaryItem(
        icon: Icons.workspace_premium,
        label: "Numero Laureati",
        value: summary.numberOfGraduates.toString(),
      ),
      _SummaryItem(
        icon: Icons.card_giftcard,
        label: "Borse ER.GO",
        value: summary.ergoScholarships.toString(),
      ),
      _SummaryItem(
        icon: Icons.timelapse,
        label: "Iscritti in Corso",
        value: summary.onTimeEnrolledPercentage,
        isPercentage: true,
      ),
    ];

    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth > 600;
    final itemWidth = isWide ? (screenWidth - 64) / 2 : screenWidth;

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children:
          entries
              .map(
                (e) => SizedBox(
                  width: itemWidth,
                  child: _TeachingSummaryCard(item: e),
                ),
              )
              .toList(),
    );
  }
}

class _SummaryItem {
  final IconData icon;
  final String label;
  final String value;
  final bool isPercentage;

  _SummaryItem({
    required this.icon,
    required this.label,
    required this.value,
    this.isPercentage = false,
  });
}

class _TeachingSummaryCard extends StatelessWidget {
  final _SummaryItem item;

  const _TeachingSummaryCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor.withAlpha(30),
              foregroundColor: Theme.of(context).primaryColor,
              child: Icon(item.icon),
            ),
            const SizedBox(width: 16),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.label,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.value,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
