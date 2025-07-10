import 'package:app_client/data/models/sections/economic.dart';
import 'package:flutter/material.dart';

class EconomicDetailTable extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: [
                  Icon(icon, color: theme.colorScheme.primary),
                  Flexible(
                    child: Text(
                      title,
                      style: theme.textTheme.titleLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                final maxWidth = constraints.maxWidth;
                final maxVoceWidth = maxWidth / 2;
                final theme = Theme.of(context);

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
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
                    columnSpacing: 24,
                    rows:
                        data.entries.map((entry) {
                          return DataRow(
                            cells: [
                              DataCell(
                                Container(
                                  constraints: BoxConstraints(
                                    maxWidth: maxVoceWidth,
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: Text(entry.name),
                                ),
                              ),
                              DataCell(
                                Center(
                                  child: Text(
                                    "${entry.value.toStringAsFixed(0)} ${data.unitOfMeasure}",
                                  ),
                                ),
                              ),
                              DataCell(Center(child: Text(entry.percentage))),
                            ],
                          );
                        }).toList(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
