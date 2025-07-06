import 'package:app_client/data/models/sections/strategy.dart';
import 'package:app_client/utility/utility.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StrategicCostsPieChart extends StatefulWidget {
  final StrategicCosts data;

  const StrategicCostsPieChart({super.key, required this.data});

  @override
  State<StrategicCostsPieChart> createState() => _StrategicCostPieChartState();
}

class _StrategicCostPieChartState extends State<StrategicCostsPieChart> {
  int? touchedIndex;

  @override
  Widget build(BuildContext context) {
    final sections = widget.data.scopes;
    final colors = Colors.primaries.take(sections.length).toList();

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "Distribuzione dei Costi Strategici",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 2,
                  centerSpaceRadius: 40,
                  pieTouchData: PieTouchData(
                    touchCallback: (event, response) {
                      if (!event.isInterestedForInteractions ||
                          response == null) {
                        return;
                      }
                      setState(() {
                        touchedIndex =
                            response.touchedSection?.touchedSectionIndex;
                      });
                    },
                  ),
                  sections: List.generate(sections.length, (i) {
                    final s = sections[i];
                    final percent = parsePercentage(s.percentage);
                    final isTouched = i == touchedIndex;
                    return PieChartSectionData(
                      value: percent,
                      title: s.percentage,
                      color: colors[i % colors.length],
                      radius: isTouched ? 70 : 60,
                      titleStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Legend
            Wrap(
              spacing: 16,
              runSpacing: 8,
              children: List.generate(sections.length, (i) {
                final s = sections[i];
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: colors[i % colors.length],
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(s.name),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
