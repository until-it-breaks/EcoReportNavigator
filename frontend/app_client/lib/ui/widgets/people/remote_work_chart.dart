import 'package:app_client/data/models/sections/people.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class RemoteWorkBarChart extends StatelessWidget {
  final RemoteWorkData data;

  const RemoteWorkBarChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final entries = data.entries;
    final barGroups = <BarChartGroupData>[];
    final barColors = [Colors.blue, Colors.orange, Colors.green];

    for (int i = 0; i < entries.length; i++) {
      final e = entries[i];

      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            if (e.year2021 != null)
              BarChartRodData(
                toY: e.year2021!.toDouble(),
                color: barColors[0],
                width: 10,
              ),
            if (e.year2022 != null)
              BarChartRodData(
                toY: e.year2022!.toDouble(),
                color: barColors[1],
                width: 10,
              ),
            if (e.year2023 != null)
              BarChartRodData(
                toY: e.year2023!.toDouble(),
                color: barColors[2],
                width: 10,
              ),
          ],
          barsSpace: 4,
        ),
      );
    }

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lavoro da Remoto',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(
              height: 300,
              child: BarChart(
                BarChartData(
                  barGroups: barGroups,
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        maxIncluded: false,
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          return Text(value.toInt().toString());
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, _) {
                          if (value.toInt() >= entries.length) {
                            return const SizedBox.shrink();
                          }
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              entries[value.toInt()].type,
                              style: const TextStyle(fontSize: 10),
                            ),
                          );
                        },
                      ),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  gridData: FlGridData(show: true),
                  borderData: FlBorderData(show: false),
                  barTouchData: BarTouchData(enabled: true),
                ),
              ),
            ),
            // Legend
            Row(
              spacing: 8,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLegendDot(barColors[0], '2021'),
                _buildLegendDot(barColors[1], '2022'),
                _buildLegendDot(barColors[2], '2023'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendDot(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(label),
      ],
    );
  }
}
