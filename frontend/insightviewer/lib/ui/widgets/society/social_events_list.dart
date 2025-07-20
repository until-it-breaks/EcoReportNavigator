import 'package:flutter/material.dart';
import 'package:insightviewer/data/models/topics/society/social_event.dart';

class SocialEventList extends StatelessWidget {
  final List<SocialEvent> events;

  const SocialEventList({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Eventi', style: theme.textTheme.titleLarge),
            ...events.map((event) {
              return Card(
                surfaceTintColor: theme.primaryColorLight,
                elevation: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: colorScheme.primary.withValues(
                        alpha: 0.1,
                      ),
                      foregroundColor: colorScheme.primary,
                      child: Text(
                        event.amount.toString(),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(event.name, style: theme.textTheme.bodyLarge),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
