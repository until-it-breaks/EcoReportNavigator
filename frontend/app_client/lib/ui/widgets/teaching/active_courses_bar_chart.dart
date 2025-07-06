import 'dart:math';

import 'package:app_client/data/models/sections/teaching.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ActiveCoursesBarChart extends StatelessWidget {
  final List<ActiveCourses> activeCourses;

  const ActiveCoursesBarChart({super.key, required this.activeCourses});

  @override
  Widget build(BuildContext context) {
    // Collect and sort all distinct years
    final allYears = <String>{};
    for (var course in activeCourses) {
      for (var data in course.years) {
        allYears.add(data.year);
      }
    }
    final sortedYears = allYears.toList()..sort();

    // Create bar groups
    final barGroups = <BarChartGroupData>[];
    for (int i = 0; i < sortedYears.length; i++) {
      final year = sortedYears[i];
      final barRods = <BarChartRodData>[];

      for (int j = 0; j < activeCourses.length; j++) {
        final course = activeCourses[j];
        final yearlyData = course.years.firstWhere(
          (y) => y.year == year,
          orElse: () => YearlyCourseData(year: year, value: 0),
        );

        barRods.add(
          BarChartRodData(
            toY: yearlyData.value.toDouble(),
            width: 12,
            color: Colors.primaries[j % Colors.primaries.length],
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }

      barGroups.add(BarChartGroupData(x: i, barRods: barRods, barsSpace: 2));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Corsi Attivati per Anno",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 12),

        /// Chart inside scrollable horizontal container
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            height: 300,
            width: max(
              sortedYears.length * 80.0,
              MediaQuery.of(context).size.width,
            ),
            child: BarChart(
              BarChartData(
                barGroups: barGroups,
                alignment: BarChartAlignment.spaceAround,
                gridData: FlGridData(show: true),
                borderData: FlBorderData(show: false),
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      return BarTooltipItem(
                        rod.toY.toInt().toString(),
                        const TextStyle(color: Colors.white),
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget:
                          (value, meta) => Text(value.toInt().toString()),
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        return SideTitleWidget(
                          space: 6,
                          meta: meta,
                          child: Text(
                            index < sortedYears.length
                                ? sortedYears[index]
                                : '',
                            style: const TextStyle(fontSize: 10),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Legend
        Wrap(
          spacing: 12,
          runSpacing: 8,
          children: [
            for (int i = 0; i < activeCourses.length; i++)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    color: Colors.primaries[i % Colors.primaries.length],
                  ),
                  const SizedBox(width: 4),
                  Text(activeCourses[i].name),
                ],
              ),
          ],
        ),
      ],
    );
  }
}
