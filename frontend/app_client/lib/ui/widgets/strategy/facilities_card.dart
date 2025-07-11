import 'package:app_client/data/models/sections/strategy.dart';
import 'package:flutter/material.dart';

class FacilitiesCard extends StatelessWidget {
  final Facilities facilities;

  const FacilitiesCard({super.key, required this.facilities});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Text("Strutture", style: theme.textTheme.titleLarge)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _FacilityStat(
                  label: "Scuole",
                  count: facilities.schoolAmount,
                  icon: Icons.account_balance,
                ),
                _FacilityStat(
                  label: "Dipartimenti",
                  count: facilities.departmentAmount,
                  icon: Icons.apartment,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FacilityStat extends StatelessWidget {
  final String label;
  final int count;
  final IconData? icon;

  const _FacilityStat({required this.label, required this.count, this.icon});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          "$count",
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            Icon(icon, color: theme.colorScheme.primary),
            SizedBox(width: 8),
            Text(label),
          ],
        ),
      ],
    );
  }
}
