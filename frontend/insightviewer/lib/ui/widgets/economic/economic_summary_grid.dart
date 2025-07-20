import 'package:insightviewer/data/models/topics/economic/economic_value_summary.dart';
import 'package:insightviewer/ui/widgets/summary_grid.dart';
import 'package:insightviewer/utility/utility.dart';
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
          value: formatValueWithUnitWithThousandsSeparator(
            summary.attractedValue,
          ),
        ),
        SummaryItem(
          icon: Icons.arrow_upward,
          label: "Valore Distribuito",
          value: formatValueWithUnitWithThousandsSeparator(
            summary.distributedValue,
          ),
        ),
        SummaryItem(
          icon: Icons.percent,
          label: "5x1000",
          value: formatValueWithUnitWithThousandsSeparator(
            summary.fivePerThousand,
          ),
        ),
        SummaryItem(
          icon: Icons.eco,
          label: "Acquisti Verdi",
          value: summary.greenPurchasesPercentage,
        ),
      ],
    );
  }
}
