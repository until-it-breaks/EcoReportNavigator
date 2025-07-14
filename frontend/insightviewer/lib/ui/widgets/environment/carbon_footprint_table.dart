import 'dart:ui';

import 'package:insightviewer/data/models/sections/environment.dart';
import 'package:insightviewer/utility/utility.dart';
import 'package:flutter/material.dart';

class CarbonFootprintTable extends StatefulWidget {
  final CarbonFootprint carbonFootprint;

  const CarbonFootprintTable({super.key, required this.carbonFootprint});

  @override
  State<CarbonFootprintTable> createState() => _CarbonFootprintTableState();
}

class _CarbonFootprintTableState extends State<CarbonFootprintTable> {
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
                  Icon(Icons.eco, color: theme.colorScheme.primary),
                  Text(
                    "Carbon Footprint",
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
                          "Area",
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      DataColumn(
                        headingRowAlignment: MainAxisAlignment.center,
                        label: Text(
                          "2022",
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      DataColumn(
                        headingRowAlignment: MainAxisAlignment.center,
                        label: Text(
                          "2023",
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                    rows:
                        widget.carbonFootprint.data.map((entry) {
                          return DataRow(
                            cells: [
                              DataCell(Text(entry.area)),
                              DataCell(
                                Center(
                                  child: Text(
                                    formatIntWithThousandsSeparator(
                                      entry.year2022,
                                    ),
                                  ),
                                ),
                              ),
                              DataCell(
                                Center(
                                  child: Text(
                                    formatIntWithThousandsSeparator(
                                      entry.year2023,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                  ),
                ),
              ),
            ),

            Center(
              child: Text(
                'Unità di misura: ${widget.carbonFootprint.unitOfMeasure}',
                style: theme.textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
