import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:insightviewer/data/models/topics/economic/economic_value_detailed.dart';

class EconomicDetailTable extends StatefulWidget {
  final String title;
  final EconomicValueDetailed data;
  final IconData? icon;

  const EconomicDetailTable({
    super.key,
    required this.title,
    required this.data,
    this.icon,
  });

  @override
  State<EconomicDetailTable> createState() => _EconomicDetailTableState();
}

class _EconomicDetailTableState extends State<EconomicDetailTable> {
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
                  Icon(widget.icon, color: theme.colorScheme.primary),
                  Flexible(
                    child: Text(
                      widget.title,
                      style: theme.textTheme.titleLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
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
                          "Voce",
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      DataColumn(
                        headingRowAlignment: MainAxisAlignment.center,
                        label: Text(
                          "Valore",
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      DataColumn(
                        headingRowAlignment: MainAxisAlignment.center,
                        label: Text(
                          "%",
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                    rows:
                        widget.data.entries.map((entry) {
                          return DataRow(
                            cells: [
                              DataCell(
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(entry.name),
                                ),
                              ),
                              DataCell(
                                Center(
                                  child: Text(
                                    "${entry.value.toStringAsFixed(0)} ${widget.data.unitOfMeasure}",
                                  ),
                                ),
                              ),
                              DataCell(Center(child: Text(entry.percentage))),
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
