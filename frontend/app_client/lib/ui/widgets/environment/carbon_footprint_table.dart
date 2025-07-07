import 'package:app_client/data/models/sections/environment.dart';
import 'package:flutter/material.dart';

class CarbonFootprintTable extends StatelessWidget {
  final CarbonFootprint carbonFootprint;

  const CarbonFootprintTable({super.key, required this.carbonFootprint});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Unit of Measure: ${carbonFootprint.unitOfMeasure}',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 8),
        DataTable(
          columns: const [
            DataColumn(label: Text("Area")),
            DataColumn(label: Text("2022")),
            DataColumn(label: Text("2023")),
          ],
          rows:
              carbonFootprint.data.map((entry) {
                return DataRow(
                  cells: [
                    DataCell(Text(entry.area)),
                    DataCell(Text("${entry.year2022}")),
                    DataCell(Text("${entry.year2023}")),
                  ],
                );
              }).toList(),
        ),
      ],
    );
  }
}
