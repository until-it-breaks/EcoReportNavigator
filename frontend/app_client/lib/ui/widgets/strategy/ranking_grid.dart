import 'package:app_client/data/models/sections/strategy.dart';
import 'package:flutter/material.dart';

class RankingCard extends StatelessWidget {
  final UniversityRanking ranking;

  const RankingCard({super.key, required this.ranking});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ranking.name,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              '🇮🇹 Posizione In Italia: ${ranking.positionInItaly}',
              style: theme.textTheme.bodyLarge,
            ),
            if (ranking.positionInTheWorld != null)
              Text(
                '🌐 Posizione Nel Mondo: ${ranking.positionInTheWorld}',
                style: theme.textTheme.bodyLarge,
              ),
          ],
        ),
      ),
    );
  }
}

class RankingGrid extends StatelessWidget {
  final List<UniversityRanking> rankings;

  const RankingGrid({super.key, required this.rankings});

  @override
  Widget build(BuildContext context) {
    final double itemSpacing = 16;
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final isWide = maxWidth > 600;
        final cardWidth = isWide ? (maxWidth - itemSpacing) / 2 : maxWidth;

        return Wrap(
          spacing: itemSpacing,
          runSpacing: 4,
          children:
              rankings.map((ranking) {
                return SizedBox(
                  width: cardWidth,
                  child: RankingCard(ranking: ranking),
                );
              }).toList(),
        );
      },
    );
  }
}
