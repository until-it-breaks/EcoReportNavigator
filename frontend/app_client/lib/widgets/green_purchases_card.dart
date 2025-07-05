import 'package:app_client/models/sections/economic_value.dart';
import 'package:flutter/material.dart';

class GreenPurchasesCard extends StatelessWidget {
  final GreenPurchases data;

  const GreenPurchasesCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Acquisti Verdi",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _GreenValueItem(
                  label: "2022",
                  value: data.percentageOf2022,
                  icon: Icons.calendar_today,
                ),
                _GreenValueItem(
                  label: "2023",
                  value: data.percentageOf2023,
                  icon: Icons.check_circle,
                  highlight: true,
                ),
                _GreenValueItem(
                  label: "Target 2024",
                  value: data.targetPercentageOf2024,
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

class _GreenValueItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final bool highlight;

  const _GreenValueItem({
    required this.label,
    required this.value,
    required this.icon,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = highlight ? Theme.of(context).primaryColor : Colors.grey[600];

    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(color: color, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: highlight ? FontWeight.bold : FontWeight.normal,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
