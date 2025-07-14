import 'package:flutter/material.dart';

class SummaryItem {
  final IconData icon;
  final String label;
  final String value;
  final String? percentageChange;

  SummaryItem({
    required this.icon,
    required this.label,
    required this.value,
    this.percentageChange,
  });
}

class SummaryCard extends StatelessWidget {
  final SummaryItem item;

  const SummaryCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          spacing: 16,
          children: [
            CircleAvatar(
              backgroundColor: theme.colorScheme.primary.withAlpha(25),
              foregroundColor: theme.colorScheme.primary,
              child: Icon(item.icon),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4,
                children: [
                  Text(item.label, style: theme.textTheme.bodyLarge),
                  RichText(
                    text: TextSpan(
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(text: item.value),
                        if (item.percentageChange != null) ...[
                          TextSpan(text: '  '),
                          TextSpan(
                            text: '(${item.percentageChange})',
                            style: TextStyle(
                              color:
                                  item.percentageChange!.startsWith('-')
                                      ? Colors.red
                                      : Colors.green,
                            ),
                          ),
                        ],
                      ],
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

class SummaryGrid extends StatelessWidget {
  final List<SummaryItem> items;

  const SummaryGrid({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final spacing = 16.0;
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final isWide = maxWidth > 600;
        final itemWidth = isWide ? (maxWidth - spacing) / 2 : maxWidth;

        return Wrap(
          spacing: spacing,
          runSpacing: 12,
          children:
              items
                  .map(
                    (item) => SizedBox(
                      width: itemWidth,
                      child: SummaryCard(item: item),
                    ),
                  )
                  .toList(),
        );
      },
    );
  }
}
