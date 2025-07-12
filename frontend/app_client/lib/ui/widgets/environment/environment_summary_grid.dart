import 'package:app_client/data/models/sections/environment.dart';
import 'package:app_client/ui/widgets/summary_grid.dart';
import 'package:app_client/utility/utility.dart';
import 'package:flutter/material.dart';

class EnvironmentSummaryGrid extends StatelessWidget {
  final EnvironmentSummary summary;

  const EnvironmentSummaryGrid({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    return SummaryGrid(
      items: [
        SummaryItem(
          icon: Icons.solar_power,
          label: "Superficie Fotovoltaica",
          value: formatValueWithUnitWithThousandsSeparator(
            summary.photovoltaicSurface,
          ),
        ),
        SummaryItem(
          icon: Icons.eco,
          label: "Insegnamenti su Tematiche Ambientali",
          value: formatIntWithThousandsSeparator(summary.environmentalCourses),
        ),
        SummaryItem(
          icon: Icons.bolt,
          label: "Energia da Fonti Rinnovabili",
          value: formatValueWithUnitWithThousandsSeparator(
            summary.renewableEnergy,
          ),
        ),
        SummaryItem(
          icon: Icons.directions_bus,
          label: "Abbonamenti Agevolati",
          value: formatIntWithThousandsSeparator(
            summary.subsidizedSubscriptions,
          ),
        ),
        SummaryItem(
          icon: Icons.euro,
          label: "Spesa per Abbonamenti Agevolati",
          value: formatValueWithUnitWithThousandsSeparator(
            summary.subscriptionSpending,
          ),
        ),
      ],
    );
  }
}
