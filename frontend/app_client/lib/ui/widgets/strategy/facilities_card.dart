import 'package:app_client/data/models/sections/strategy.dart';
import 'package:flutter/material.dart';

class FacilitiesCard extends StatelessWidget {
  final Facilities facilities;

  const FacilitiesCard({super.key, required this.facilities});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _FacilityStat(label: "Scuole", count: facilities.schoolAmount),
            _FacilityStat(
              label: "Dipartimenti",
              count: facilities.departmentAmount,
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

  const _FacilityStat({required this.label, required this.count});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "$count",
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(label),
      ],
    );
  }
}
