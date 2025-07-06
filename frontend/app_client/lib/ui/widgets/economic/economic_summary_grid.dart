import 'package:app_client/data/models/sections/economic.dart';
import 'package:app_client/ui/widgets/summary_grid.dart';
import 'package:flutter/material.dart';

class EconomicSummaryGrid extends StatelessWidget {
  final EconomicValueSummary summary;

  const EconomicSummaryGrid({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    return SummaryGrid(
      items: [
        SummaryItem(
          icon: Icons.arrow_downward,
          label: "Valore Attratto",
          value: _formatValue(summary.attractedValue),
        ),
        SummaryItem(
          icon: Icons.arrow_upward,
          label: "Valore distribuito",
          value: _formatValue(summary.distributedValue),
        ),
        SummaryItem(
          icon: Icons.percent,
          label: "5x1000",
          value: _formatValue(summary.fivePerThousand),
        ),
        SummaryItem(
          icon: Icons.eco,
          label: "Acquisti verdi",
          value: summary.greenPurchasesPercentage.toString(),
          percentageChange: null,
        ),
      ],
    );
  }

  String _formatValue(ValueWithUnit? value) {
    if (value == null) return "-";
    return "${value.value.toStringAsFixed(2)} ${value.unitOfMeasure}";
  }
}
