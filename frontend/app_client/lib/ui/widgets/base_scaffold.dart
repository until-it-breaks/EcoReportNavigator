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
          spacing: 8,
          children: [
            Icon(
              category.icon,
              size: 36,
              color: Theme.of(context).colorScheme.primary,
            ),
            Flexible(
              child: Text(
                category.name,
                style: Theme.of(context).textTheme.headlineSmall,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
        actions: [ThemeToggleButton(themeNotifier: themeNotifier)],
        actionsPadding: EdgeInsets.all(8),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: body,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        child: const Icon(Icons.chat),
      ),
    );
  }
}
