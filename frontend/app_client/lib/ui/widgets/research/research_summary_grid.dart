import 'package:app_client/data/models/sections/research.dart';
import 'package:flutter/material.dart';

class ResearchSummaryGrid extends StatelessWidget {
  final ResearchSummary summary;

  const ResearchSummaryGrid({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    final entries = [
      _SummaryItem(
        icon: Icons.science,
        label: "Progetti Horizon Europe",
        value: summary.horizonEuropeProjects.toString(),
      ),
      _SummaryItem(
        icon: Icons.school,
        label: "Assegni di ricerca",
        value: summary.researchGrants.toString(),
      ),
      _SummaryItem(
        icon: Icons.flight_takeoff,
        label: "Docenti Outgoing",
        value: summary.outgoingProfessors.toString(),
      ),
      _SummaryItem(
        icon: Icons.monetization_on,
        label: summary.cascadeFundingPnrrPnc.description,
        value:
            "${summary.cascadeFundingPnrrPnc.value} ${summary.cascadeFundingPnrrPnc.unit}",
      ),
      _SummaryItem(
        icon: Icons.menu_book,
        label: "Pubblicazioni",
        value: summary.publications.toString(),
      ),
      _SummaryItem(
        icon: Icons.people_alt,
        label: "Visiting Professors e PhD",
        value: summary.visitingProfessorsAndPhd.toString(),
      ),
    ];

    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth > 600;
    final itemWidth = isWide ? (screenWidth - 64) / 2 : screenWidth;

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children:
          entries
              .map(
                (e) => SizedBox(
                  width: itemWidth,
                  child: _ResearchSummaryCard(item: e),
                ),
              )
              .toList(),
    );
  }
}

class _SummaryItem {
  final IconData icon;
  final String label;
  final String value;

  _SummaryItem({required this.icon, required this.label, required this.value});
}

class _ResearchSummaryCard extends StatelessWidget {
  final _SummaryItem item;

  const _ResearchSummaryCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor.withAlpha(30),
              foregroundColor: Theme.of(context).primaryColor,
              child: Icon(item.icon),
            ),
            const SizedBox(width: 16),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.label,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.value,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
