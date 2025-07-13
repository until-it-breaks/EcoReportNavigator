import 'package:flutter/material.dart';

class ChatBottomSheet extends StatelessWidget {
  const ChatBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      builder: (context, scrollController) {
        return Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            color: Theme.of(context).colorScheme.surface,
          ),
          child: ListView(
            controller: scrollController,
            children: [
              Text(
                "AI Assistant",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  hintText: "Ask something...",
                  suffixIcon: Icon(Icons.send),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
