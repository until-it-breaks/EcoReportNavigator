import 'package:app_client/data/models/sections/teaching.dart';
import 'package:app_client/utility/utility.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GenderPieCharts extends StatefulWidget {
  final EnrollmentByGender enrollmentByGender;

  const GenderPieCharts({super.key, required this.enrollmentByGender});

  @override
  State<GenderPieCharts> createState() => _GenderPieChartsState();
}

class _GenderPieChartsState extends State<GenderPieCharts> {
  late String selectedYear;
  late List<String> availableYears;

  @override
  void initState() {
    super.initState();
    availableYears =
        widget.enrollmentByGender.total.map((e) => e.year).toList()..sort();
    selectedYear = availableYears.last;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final compositions = [
      ('STEM', _compositionForYear(widget.enrollmentByGender.stem)),
      ('Non-STEM', _compositionForYear(widget.enrollmentByGender.nonStem)),
      ('Totale', _compositionForYear(widget.enrollmentByGender.total)),
    ];

    final isWide = MediaQuery.of(context).size.width > 800;

    final charts =
        isWide
            ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  compositions
                      .map(
                        (e) => Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: _GenderPieChart(
                              title: e.$1,
                              composition: e.$2,
                            ),
                          ),
                        ),
                      )
                      .toList(),
            )
            : Column(
              children:
                  compositions
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: _GenderPieChart(
                            title: e.$1,
                            composition: e.$2,
                          ),
                        ),
                      )
                      .toList(),
            );

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Row(
                spacing: 8,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.wc, color: theme.colorScheme.primary),
                  Flexible(
                    child: Text(
                      textAlign: TextAlign.center,
                      'Composizione delle iscrizioni per genere',
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              spacing: 8,
              children: [
                const Text('Anno:'),
                DropdownButton<String>(
                  value: selectedYear,
                  items:
                      availableYears
                          .map(
                            (year) => DropdownMenuItem(
                              value: year,
                              child: Text(year),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => selectedYear = value);
                    }
                  },
                ),
              ],
            ),
            charts,
          ],
        ),
      ),
    );
  }

  GenderComposition _compositionForYear(List<GenderComposition> list) {
    return list.firstWhere((e) => e.year == selectedYear);
  }
}

class _GenderPieChart extends StatelessWidget {
  final String title;
  final GenderComposition composition;

  const _GenderPieChart({required this.title, required this.composition});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final women = parsePercentage(composition.women);
    final men = parsePercentage(composition.men);

    return Column(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: theme.textTheme.titleMedium),
        SizedBox(
          height: 180,
          child: PieChart(
            PieChartData(
              centerSpaceRadius: 36,
              sectionsSpace: 2,
              sections: [
                PieChartSectionData(
                  color: Colors.pinkAccent,
                  value: women,
                  title: '${women.toStringAsFixed(1)}%',
                  radius: 60,
                ),
                PieChartSectionData(
                  color: Colors.blueAccent,
                  value: men,
                  title: '${men.toStringAsFixed(1)}%',
                  radius: 60,
                ),
              ],
            ),
          ),
        ),
        Row(
          spacing: 16,
          children: const [
            _LegendItem(color: Colors.pinkAccent, label: 'Donne'),
            _LegendItem(color: Colors.blueAccent, label: 'Uomini'),
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
      spacing: 4,
      children: [Container(width: 12, height: 12, color: color), Text(label)],
    );
  }
}
