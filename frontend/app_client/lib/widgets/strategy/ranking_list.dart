import 'package:app_client/models/sections/strategy.dart';
import 'package:flutter/material.dart';

class RankingList extends StatelessWidget {
  final List<UniversityRanking> rankings;

  const RankingList({super.key, required this.rankings});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          rankings.map((r) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text(
                  r.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Italia: ${r.positionInItaly}"),
                    if (r.positionInTheWorld != null)
                      Text("Mondo: ${r.positionInTheWorld}"),
                    if (r.comment != null) Text("Commento: ${r.comment}"),
                  ],
                ),
              ),
            );
          }).toList(),
    );
  }
}
