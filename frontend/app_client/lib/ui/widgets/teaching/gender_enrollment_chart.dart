import 'dart:math';

import 'package:app_client/data/models/sections/teaching.dart';
import 'package:app_client/utility/utility.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GenderEnrollmentChart extends StatefulWidget {
  final EnrollmentByGender enrollmentByGender;

  const GenderEnrollmentChart({super.key, required this.enrollmentByGender});

  @override
  State<GenderEnrollmentChart> createState() => _GenderEnrollmentChartState();
}

class _GenderEnrollmentChartState extends State<GenderEnrollmentChart> {
  String selectedCategory = 'STEM';

  List<GenderComposition> get currentData {
    switch (selectedCategory) {
      case 'STEM':
        return widget.enrollmentByGender.stem;
      case 'Non-STEM':
        return widget.enrollmentByGender.nonStem;
      case 'Total':
      default:
        return widget.enrollmentByGender.total;
    }
  }

  @override
  Widget build(BuildContext context) {
    final years = currentData.map((e) => e.year).toList();
    final barGroups = <BarChartGroupData>[];

    for (int i = 0; i < currentData.length; i++) {
      final entry = currentData[i];

      final womenValue = parsePercentage(entry.women);
      final menValue = parsePercentage(entry.men);

      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: 100,
              rodStackItems: [
                BarChartRodStackItem(0, womenValue, Colors.pinkAccent),
                BarChartRodStackItem(womenValue, 100, Colors.blueAccent),
              ],
              width: 20,
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Dropdown
        Row(
          children: [
            const Text('Categoria:'),
            const SizedBox(width: 8),
            DropdownButton<String>(
              value: selectedCategory,
              items: const [
                DropdownMenuItem(value: 'STEM', child: Text('STEM')),
                DropdownMenuItem(value: 'Non-STEM', child: Text('Non-STEM')),
                DropdownMenuItem(value: 'Total', child: Text('Totale')),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() => selectedCategory = value);
                }
              },
            ),
          ],
        ),

        const SizedBox(height: 16),

        /// Chart
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            height: 300,
            width: max(
              currentData.length * 80.0,
              MediaQuery.of(context).size.width,
            ),
            child: BarChart(
              BarChartData(
                barGroups: barGroups,
                barTouchData: BarTouchData(enabled: false),
                alignment: BarChartAlignment.spaceAround,
                borderData: FlBorderData(show: false),
                gridData: FlGridData(show: true, drawVerticalLine: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 32,
                      getTitlesWidget:
                          (value, meta) => Text(
                            '${value.toInt()}%',
                            style: const TextStyle(fontSize: 10),
                          ),
                      interval: 20,
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        return SideTitleWidget(
                          meta: meta,
                          space: 6,
                          child: Text(
                            index < years.length ? years[index] : '',
                            style: const TextStyle(fontSize: 10),
                          ),
                        );
                      },
                    ),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                maxY: 100,
              ),
            ),
          ),
        ),

        const SizedBox(height: 12),

        /// Legend
        Wrap(
          spacing: 12,
          children: const [
            _LegendItem(color: Colors.pinkAccent, label: "Donne"),
            _LegendItem(color: Colors.blueAccent, label: "Uomini"),
          ],
        ),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 12, height: 12, color: color),
        const SizedBox(width: 4),
        Text(label),
      ],
    );
  }
}
