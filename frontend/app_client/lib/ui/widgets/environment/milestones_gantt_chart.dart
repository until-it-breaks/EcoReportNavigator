import 'package:app_client/data/models/sections/environment.dart';
import 'package:flutter/material.dart';

class MilestoneTable extends StatelessWidget {
  final List<EnergyPlanMilestone> milestones;

  const MilestoneTable({super.key, required this.milestones});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const [
        DataColumn(label: Text("Attività")),
        DataColumn(label: Text("Anno di inizio")),
        DataColumn(label: Text("Anno di fine")),
        DataColumn(label: Text("Durata")),
      ],
      rows:
          milestones.map((milestone) {
            final duration = milestone.endYear - milestone.startYear + 1;
            return DataRow(
              cells: [
                DataCell(Text(milestone.activity)),
                DataCell(Text('${milestone.startYear}')),
                DataCell(Text('${milestone.endYear}')),
                DataCell(Text('$duration anno/i')),
              ],
            );
          }).toList(),
    );
  }
}
