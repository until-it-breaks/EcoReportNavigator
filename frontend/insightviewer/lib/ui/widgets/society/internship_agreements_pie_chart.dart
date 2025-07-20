import 'package:insightviewer/data/models/topics/society/internship_agreements_data.dart';
import 'package:insightviewer/utility/utility.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class InternshipAgreementsPieChart extends StatefulWidget {
  final InternshipAgreementsData data;

  const InternshipAgreementsPieChart({super.key, required this.data});

  @override
  State<InternshipAgreementsPieChart> createState() =>
      _InternshipAgreementsPieChartState();
}

class _InternshipAgreementsPieChartState
    extends State<InternshipAgreementsPieChart> {
  int? touchedIndex;

  @override
  Widget build(BuildContext context) {
    final sections = widget.data.agreements;
    final colors = Colors.primaries.take(sections.length).toList();

    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 24,
          children: [
            Text(
              "Distribuzione Convenzioni di Tirocinio",
              style: theme.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 2,
                  centerSpaceRadius: 48,
                  pieTouchData: PieTouchData(
                    touchCallback: (event, response) {
                      if (!event.isInterestedForInteractions ||
                          response == null) {
                        setState(() => touchedIndex = null);
                        return;
                      }
                      setState(() {
                        touchedIndex =
                            response.touchedSection?.touchedSectionIndex;
                      });
                    },
                  ),
                  sections: List.generate(sections.length, (i) {
                    final section = sections[i];
                    final percent = parsePercentage(section.percentage);
                    final isTouched = i == touchedIndex;

                    return PieChartSectionData(
                      value: percent,
                      title: section.percentage,
                      color: colors[i % colors.length],
                      radius: isTouched ? 72 : 64,
                    );
                  }),
                ),
              ),
            ),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 16,
              runSpacing: 8,
              children: List.generate(sections.length, (i) {
                final section = sections[i];
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 4,
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: colors[i % colors.length],
                        shape: BoxShape.circle,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        section.name,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                );
              }),
            ),
            Text(
              "Totale convenzioni: ${widget.data.totalAgreements}",
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
