import 'package:app_client/data/models/sections/society.dart';
import 'package:flutter/material.dart';

class SocialEventList extends StatelessWidget {
  final Events data;

  const SocialEventList({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 2,
      color: colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Eventi',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: colorScheme.primary,
                ),
              ),
            ),
            ...data.events.map((event) {
              return Card(
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
                        event.eventCount.toString(),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(event.type, style: theme.textTheme.bodyLarge),
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
