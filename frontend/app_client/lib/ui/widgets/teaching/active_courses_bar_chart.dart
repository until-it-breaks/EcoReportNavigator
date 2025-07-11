import 'package:app_client/data/models/sections/teaching.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ActiveCoursesBarChart extends StatefulWidget {
  final List<ActiveCourse> activeCourses;

  const ActiveCoursesBarChart({super.key, required this.activeCourses});

  @override
  State<ActiveCoursesBarChart> createState() => _ActiveCoursesBarChartState();
}

class _ActiveCoursesBarChartState extends State<ActiveCoursesBarChart> {
  late final ScrollController _horizontalController;
  late List<String> sortedYears;
  String? _selectedYear;

  @override
  void initState() {
    super.initState();
    _horizontalController = ScrollController();

    final allYears = <String>{};
    for (var course in widget.activeCourses) {
      for (var yearlyCourseInfo in course.yearlyInfo) {
        allYears.add(yearlyCourseInfo.year);
      }
    }
    sortedYears = allYears.toList()..sort();
    _selectedYear = sortedYears.isNotEmpty ? sortedYears.last : null;
  }

  @override
  void dispose() {
    _horizontalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final maxAmount = widget.activeCourses
        .expand((course) => course.yearlyInfo)
        .map((data) => data.amount)
        .fold<int>(0, (prev, amount) => amount > prev ? amount : prev);

    final barGroups = <BarChartGroupData>[];

    if (_selectedYear != null) {
      final barRods = <BarChartRodData>[];

      for (int i = 0; i < widget.activeCourses.length; i++) {
        final course = widget.activeCourses[i];
        final yearlyData = course.yearlyInfo.firstWhere(
          (y) => y.year == _selectedYear,
          orElse: () => YearlyCourseData(year: _selectedYear!, amount: 0),
        );

        barRods.add(
          BarChartRodData(
            toY: yearlyData.amount.toDouble(),
            width: 16,
            color: Colors.primaries[i % Colors.primaries.length],
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }

      barGroups.add(BarChartGroupData(x: 0, barRods: barRods, barsSpace: 6));
    }

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
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: [
                  Icon(Icons.co_present, color: theme.colorScheme.primary),
                  Text("Corsi Attivi", style: theme.textTheme.titleLarge),
                ],
              ),
            ),

            Row(
              spacing: 8,
              children: [
                const Text("Anno:"),
                DropdownButton<String>(
                  value: _selectedYear,
                  onChanged: (newYear) {
                    setState(() => _selectedYear = newYear);
                  },
                  items:
                      sortedYears
                          .map(
                            (year) => DropdownMenuItem(
                              value: year,
                              child: Text(year),
                            ),
                          )
                          .toList(),
                ),
              ],
            ),

            SizedBox(
              height: 400,
              child: BarChart(
                BarChartData(
                  barGroups: barGroups,
                  maxY: maxAmount.toDouble(),
                  gridData: FlGridData(show: true),
                  borderData: FlBorderData(show: false),
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchTooltipData: BarTouchTooltipData(
                      fitInsideHorizontally: true,
                      fitInsideVertically: true,
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
                        maxIncluded: false,
                        showTitles: true,
                        reservedSize: 48,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                ),
              ),
            ),

            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: [
                for (int i = 0; i < widget.activeCourses.length; i++)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        color: Colors.primaries[i % Colors.primaries.length],
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          widget.activeCourses[i].name,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
