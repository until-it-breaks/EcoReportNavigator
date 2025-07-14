import 'package:insightviewer/data/models/sections/economic.dart';
import 'package:flutter/material.dart';

class GreenPurchasesCard extends StatelessWidget {
  final GreenPurchases greenPurchases;

  const GreenPurchasesCard({super.key, required this.greenPurchases});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: [
                  Icon(Icons.eco, color: theme.colorScheme.primary),
                  Text("Acquisti verdi", style: theme.textTheme.titleLarge),
                ],
              ),
            ),
            Row(
              children: [
                _GreenMilestone(
                  label: "2022",
                  value: greenPurchases.percentageOf2022,
                  icon: Icons.calendar_today,
                ),
                _GreenMilestone(
                  label: "2023",
                  value: greenPurchases.percentageOf2023,
                  icon: Icons.expand_more,
                  highlight: true,
                ),
                _GreenMilestone(
                  label: "Target 2024",
                  value: greenPurchases.targetPercentageOf2024,
                  icon: Icons.flag,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _GreenMilestone extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final bool highlight;

  const _GreenMilestone({
    required this.label,
    required this.value,
    required this.icon,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color =
        highlight ? theme.colorScheme.primary : theme.colorScheme.secondary;

    return Expanded(
      child: Column(
        spacing: 4,
        children: [
          Icon(icon, color: color),
          Text(
            label,
            style: TextStyle(color: color, fontWeight: FontWeight.w600),
          ),
          Text(
            value,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: highlight ? FontWeight.bold : FontWeight.normal,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
