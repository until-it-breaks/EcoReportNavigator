import 'package:app_client/models/sections/teaching.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SdgsTeachingChart extends StatelessWidget {
  final List<SdgsTeaching> sdgsTeachings;

  const SdgsTeachingChart({super.key, required this.sdgsTeachings});

  @override
  Widget build(BuildContext context) {
    final sorted = [...sdgsTeachings]
      ..sort((a, b) => b.courseCount.compareTo(a.courseCount));
    final maxValue =
        sorted
            .map((e) => e.courseCount)
            .fold(0, (a, b) => a > b ? a : b)
            .toDouble();

    return SizedBox(
      height: sorted.length * 40.0,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceBetween,
          maxY: maxValue + (maxValue * 0.1),
          barTouchData: BarTouchData(enabled: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index < sorted.length) {
                    return Text(
                      sorted[index].goal,
                      style: const TextStyle(fontSize: 10),
                    );
                  }
                  return const SizedBox.shrink();
                },
                reservedSize: 120,
              ),
            ),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: (maxValue / 4).ceilToDouble(),
                getTitlesWidget: (value, meta) => Text('${value.toInt()}'),
              ),
            ),
          ),
          gridData: FlGridData(show: true, drawVerticalLine: true),
          borderData: FlBorderData(show: false),
          barGroups: List.generate(sorted.length, (index) {
            final data = sorted[index];
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: data.courseCount.toDouble(),
                  width: 16,
                  borderRadius: BorderRadius.circular(4),
                  color: Theme.of(context).primaryColor,
                  backDrawRodData: BackgroundBarChartRodData(
                    show: true,
                    toY: maxValue,
                    color: Colors.grey.withValues(alpha: 0.1),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
