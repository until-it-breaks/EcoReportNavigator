import 'package:app_client/core/data_categories.dart';
import 'package:flutter/material.dart';

class BaseDataCategoryPageScaffold extends StatelessWidget {
  final DataCategory category;
  final Widget body;

  const BaseDataCategoryPageScaffold({
    super.key,
    required this.category,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              category.icon,
              size: 36,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 8),
            Text(
              category.name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(child: body),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        child: const Icon(Icons.smart_toy),
      ),
    );
  }
}
