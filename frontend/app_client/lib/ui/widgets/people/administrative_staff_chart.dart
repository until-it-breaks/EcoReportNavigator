import 'package:app_client/data/models/sections/people.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AdministrativeStaffBarChart extends StatelessWidget {
  final AdministrativeStaffByYear data;

  const AdministrativeStaffBarChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final years = data.yearlyData.map((e) => e.year).toList();

    final barGroups = List.generate(data.yearlyData.length, (index) {
      final yearData = data.yearlyData[index];

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: (yearData.fullTime + yearData.partTime).toDouble(),
            width: 18,
            rodStackItems: [
              BarChartRodStackItem(
                0,
                yearData.fullTime.toDouble(),
                Colors.blue[700]!,
              ),
              BarChartRodStackItem(
                yearData.fullTime.toDouble(),
                (yearData.fullTime + yearData.partTime).toDouble(),
                Colors.blue[300]!,
              ),
            ],
          ),
        ],
      );
    });

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Personale Tecnico-Amministrativo per Anno',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: BarChart(
                BarChartData(
                  barGroups: barGroups,
                  titlesData: FlTitlesData(
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
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    topTitles: AxisTitles(),
                    rightTitles: AxisTitles(),
                  ),
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: true),
                  groupsSpace: 24,
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

  Widget _buildLegend() {
    return Row(
      children: [
        _legendDot(Colors.blue[700]!, 'Tempo Pieno'),
        const SizedBox(width: 16),
        _legendDot(Colors.blue[300]!, 'Tempo Parziale'),
      ],
    );
  }

  Widget _legendDot(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          margin: const EdgeInsets.only(right: 4),
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        Text(label),
      ],
    );
  }
}
