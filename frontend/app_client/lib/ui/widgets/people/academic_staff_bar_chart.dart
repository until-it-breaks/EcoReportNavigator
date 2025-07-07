import 'package:app_client/data/models/sections/people.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AcademicStaffBarChart extends StatelessWidget {
  final AcademicStaffByRole data;

  const AcademicStaffBarChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final years = data.fullProfessors.map((e) => e.year).toList();

    List<BarChartGroupData> barGroups = [];

    for (int i = 0; i < years.length; i++) {
      final full = data.fullProfessors[i];
      final assoc = data.associateProfessors[i];
      final perm = data.permanentResearchers[i];
      final fixed = data.fixedTermResearchers[i];

      final roles = [
        _buildStackedBar(full.fullTime, full.partTime, Colors.blue),
        _buildStackedBar(assoc.fullTime, assoc.partTime, Colors.orange),
        _buildStackedBar(perm.fullTime, perm.partTime, Colors.green),
        _buildStackedBar(fixed.fullTime, fixed.partTime, Colors.purple),
      ];

      barGroups.add(BarChartGroupData(x: i, barsSpace: 6, barRods: roles));
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Personale Accademico per Ruolo e Anno",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: BarChart(
                BarChartData(
                  barGroups: barGroups,
                  groupsSpace: 32,
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, _) {
                          final index = value.toInt();
                          if (index >= 0 && index < years.length) {
                            return Text(years[index]);
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                    topTitles: AxisTitles(),
                    rightTitles: AxisTitles(),
                  ),
                  gridData: FlGridData(show: true),
                  borderData: FlBorderData(show: false),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildLegend(),
          ],
        ),
      ),
    );
  }

  BarChartRodData _buildStackedBar(
    int full,
    int part,
    MaterialColor baseColor,
  ) {
    return BarChartRodData(
      toY: (full + part).toDouble(),
      rodStackItems: [
        BarChartRodStackItem(0, full.toDouble(), baseColor[700]!),
        BarChartRodStackItem(
          full.toDouble(),
          (full + part).toDouble(),
          baseColor[300]!,
        ),
      ],
      width: 12,
    );
  }

  Widget _buildLegend() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _legendRow(Colors.blue, 'Professori Ordinari'),
        _legendRow(Colors.orange, 'Professori Associati'),
        _legendRow(Colors.green, 'Ricercatori TI'),
        _legendRow(Colors.purple, 'Ricercatori TD'),
        const SizedBox(height: 8),
        Row(
          children: [
            buildLegendDot(Colors.black87),
            const SizedBox(width: 4),
            const Text('Tempo Pieno'),
            const SizedBox(width: 16),
            buildLegendDot(Colors.grey),
            const SizedBox(width: 4),
            const Text('Tempo Definito'),
          ],
        ),
      ],
    );
  }

  Widget _legendRow(MaterialColor color, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          buildLegendDot(color[700]!),
          const SizedBox(width: 4),
          buildLegendDot(color[300]!),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }

  Widget buildLegendDot(Color color) {
    return Container(
      width: 12,
      height: 12,
      margin: const EdgeInsets.only(right: 2),
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
