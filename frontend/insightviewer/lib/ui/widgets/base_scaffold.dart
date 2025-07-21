import 'package:insightviewer/core/app_chapter.dart';
import 'package:insightviewer/main.dart';
import 'package:insightviewer/ui/widgets/chat_bottom_sheet.dart';
import 'package:insightviewer/ui/widgets/theme_toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class BaseDataCategoryPageScaffold extends StatelessWidget {
  final AppChapter chapter;
  final Widget body;

  const BaseDataCategoryPageScaffold({
    super.key,
    required this.chapter,
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
              chapter.icon,
              size: 36,
              color: Theme.of(context).colorScheme.primary,
            ),
            Flexible(
              child: Text(
                chapter.name,
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
        onPressed:
            () => {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder:
                    (_) => ChatBottomSheet(
                      sessionId: Uuid().v4(),
                      chapter: chapter,
                    ),
              ),
            },
        child: const Icon(Icons.chat),
      ),
    );
  }
}
