import 'package:app_client/data/models/sections/society.dart';
import 'package:flutter/material.dart';

class EventCardList extends StatelessWidget {
  final Events data;

  const EventCardList({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final events = data.events;
    final colors = Colors.primaries;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Eventi', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        ...List.generate(events.length, (index) {
          final event = events[index];
          final color = colors[index % colors.length].shade300;

          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: color,
                child: Text(
                  event.eventCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(
                event.type,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              trailing: const Icon(
                Icons.event_note_rounded,
                color: Colors.grey,
              ),
            ),
          );
        }),
      ],
    );
  }
}
