import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:insightviewer/data/models/topics/environment/energy_plan_milestone.dart';

class MilestoneTable extends StatefulWidget {
  final List<EnergyPlanMilestone> milestones;

  const MilestoneTable({super.key, required this.milestones});

  @override
  State<MilestoneTable> createState() => _MilestoneTableState();
}

class _MilestoneTableState extends State<MilestoneTable> {
  final ScrollController _horizontalController = ScrollController();

  @override
  void dispose() {
    _horizontalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 16,
          children: [
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: [
                  Icon(Icons.track_changes, color: theme.colorScheme.primary),
                  Text(
                    "Milestones",
                    style: theme.textTheme.titleLarge,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            ScrollConfiguration(
              behavior: const MaterialScrollBehavior().copyWith(
                dragDevices: {
                  PointerDeviceKind.mouse,
                  PointerDeviceKind.touch,
                  PointerDeviceKind.trackpad,
                },
              ),
              child: Scrollbar(
                controller: _horizontalController,
                thumbVisibility: false,
                child: SingleChildScrollView(
                  controller: _horizontalController,
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: 24,
                    columns: [
                      DataColumn(
                        label: Text(
                          "Attività",
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      DataColumn(
                        headingRowAlignment: MainAxisAlignment.center,
                        label: Text(
                          "Inizio",
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      DataColumn(
                        headingRowAlignment: MainAxisAlignment.center,
                        label: Text(
                          "Fine",
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                    rows:
                        widget.milestones.map((milestone) {
                          return DataRow(
                            cells: [
                              DataCell(Text(milestone.activity)),
                              DataCell(
                                Center(child: Text('${milestone.startYear}')),
                              ),
                              DataCell(
                                Center(child: Text('${milestone.endYear}')),
                              ),
                            ],
                          );
                        }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
