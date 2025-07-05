import 'package:app_client/models/sections/economic_value.dart';
import 'package:flutter/material.dart';

class EconomicDetailTable extends StatelessWidget {
  final String title;
  final EconomicValueDetailed data;

  const EconomicDetailTable({
    super.key,
    required this.title,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text("Voce")),
                  DataColumn(label: Text("Valore")),
                  DataColumn(label: Text("Percentuale")),
                ],
                columnSpacing: 32,
                rows:
                    data.entries.map((entry) {
                      return DataRow(
                        cells: [
                          DataCell(Text(entry.name)),
                          DataCell(
                            Text(
                              "${entry.value.toStringAsFixed(2)} ${data.unitOfMeasure}",
                            ),
                          ),
                          DataCell(Text(entry.percentage)),
                        ],
                      );
                    }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
