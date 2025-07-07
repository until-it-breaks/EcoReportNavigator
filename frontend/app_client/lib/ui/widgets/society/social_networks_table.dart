import 'package:app_client/data/models/sections/society.dart';
import 'package:flutter/material.dart';

class SocialChannelsTable extends StatelessWidget {
  final SocialChannelsList data;

  const SocialChannelsTable({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final channels = data.channels;

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columnSpacing: 20,
            headingRowColor: WidgetStateProperty.all(Colors.grey.shade200),
            columns: const [
              DataColumn(label: Text('Canale')),
              DataColumn(label: Text('Obiettivo')),
              DataColumn(label: Text('Target')),
              DataColumn(label: Text('Follower Totali')),
              DataColumn(label: Text('Periodo')),
              DataColumn(label: Text('Crescita 2023')),
            ],
            rows:
                channels.map((channel) {
                  return DataRow(
                    cells: [
                      DataCell(Text(channel.channel)),
                      DataCell(Text(channel.objective)),
                      DataCell(Text(channel.target)),
                      DataCell(
                        Text(
                          channel.totalFollowers?.toString() ?? 'N/A',
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      DataCell(Text(channel.followersPeriod)),
                      DataCell(Text(channel.growth2023 ?? '—')),
                    ],
                  );
                }).toList(),
          ),
        ),
      ),
    );
  }
}
