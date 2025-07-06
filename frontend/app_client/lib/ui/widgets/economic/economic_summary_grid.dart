import 'package:app_client/data/models/sections/economic.dart';
import 'package:flutter/material.dart';

class EconomicSummaryGrid extends StatelessWidget {
  final EconomicValueSummary summary;

  const EconomicSummaryGrid({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    final entries = [
      _SummaryItem(
        icon: Icons.arrow_downward,
        label: "Valore Attratto",
        value: summary.attractedValue,
      ),
      _SummaryItem(
        icon: Icons.arrow_upward,
        label: "Valore distribuito",
        value: summary.distributedValue,
      ),
      _SummaryItem(
        icon: Icons.percent,
        label: "5x1000",
        value: summary.fivePerThousand,
      ),
      _SummaryItem(
        icon: Icons.eco,
        label: "Acquisti verdi",
        textValue: summary.greenPurchasesPercentage,
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
                  child: _EconomicSummaryCard(item: e),
                ),
              )
              .toList(),
    );
  }
}

class _SummaryItem {
  final IconData icon;
  final String label;
  final ValueWithUnit? value;
  final String? textValue;

  _SummaryItem({
    required this.icon,
    required this.label,
    this.value,
    this.textValue,
  });
}

class _EconomicSummaryCard extends StatelessWidget {
  final _SummaryItem item;

  const _EconomicSummaryCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final valueText =
        item.textValue ??
        "${item.value?.value.toStringAsFixed(2)} ${item.value?.unitOfMeasure}";

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Theme.of(
                context,
              ).primaryColor.withValues(alpha: 0.1),
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
                    valueText,
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
