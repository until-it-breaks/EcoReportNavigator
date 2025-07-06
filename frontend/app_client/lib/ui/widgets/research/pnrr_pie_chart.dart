import 'package:app_client/data/models/sections/research.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PnrrPieChart extends StatefulWidget {
  final Pnrr data;

  const PnrrPieChart({super.key, required this.data});

  @override
  State<PnrrPieChart> createState() => _PnrrPieChartState();
}

class _PnrrPieChartState extends State<PnrrPieChart> {
  int? touchedIndex;

  double parsePercentage(String raw) {
    // Normalize "40,73%" → 40.73
    return double.tryParse(
          raw.replaceAll('%', '').replaceAll(',', '.').trim(),
        ) ??
        0.0;
  }

  @override
  Widget build(BuildContext context) {
    final sections = widget.data.fundDistributionByMission;
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
              "Ripartizione Fondi per Missione (PNRR)",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 220,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 2,
                  centerSpaceRadius: 40,
                  pieTouchData: PieTouchData(
                    touchCallback: (event, response) {
                      if (!event.isInterestedForInteractions ||
                          response?.touchedSection == null) {
                        setState(() => touchedIndex = null);
                        return;
                      }
                      setState(() {
                        touchedIndex =
                            response!.touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  sections: List.generate(sections.length, (i) {
                    final fund = sections[i];
                    final percent = parsePercentage(fund.percentage);
                    final isTouched = i == touchedIndex;

                    return PieChartSectionData(
                      value: percent,
                      title: "${percent.toStringAsFixed(1)}%",
                      color: colors[i % colors.length],
                      radius: isTouched ? 70 : 60,
                      titleStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    );
                  }),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 8,
              children: List.generate(sections.length, (i) {
                final fund = sections[i];
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
                    Flexible(
                      child: Text(
                        fund.mission,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
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
