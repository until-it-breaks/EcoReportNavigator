import 'package:app_client/data/models/sections/environment.dart';
import 'package:app_client/ui/widgets/summary_grid.dart';
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
          value: _formatMeasured(summary.photovoltaicSurface),
        ),
        SummaryItem(
          icon: Icons.eco,
          label: "Insegnamenti su Tematiche Ambientali",
          value: summary.environmentalCourses.toString(),
        ),
        SummaryItem(
          icon: Icons.bolt,
          label: "Energia da Fonti Rinnovabili",
          value: _formatMeasured(summary.renewableEnergy),
        ),
        SummaryItem(
          icon: Icons.directions_bus,
          label: "Abbonamenti Agevolati",
          value: summary.subsidizedSubscriptions.toString(),
        ),
        SummaryItem(
          icon: Icons.euro,
          label: "Spesa per Abbonamenti Agevolati",
          value: _formatMeasured(summary.subscriptionSpending),
        ),
      ],
    );
  }

  String _formatMeasured(MeasuredValue value) {
    return "${value.value} ${value.unit}";
  }
}
