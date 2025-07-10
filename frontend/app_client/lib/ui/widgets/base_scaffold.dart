import 'package:app_client/core/data_categories.dart';
import 'package:app_client/main.dart';
import 'package:app_client/ui/widgets/theme_toggle_button.dart';
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
        actions: [ThemeToggleButton(themeNotifier: themeNotifier)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: body,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        child: const Icon(Icons.smart_toy),
      ),
    );
  }
}
