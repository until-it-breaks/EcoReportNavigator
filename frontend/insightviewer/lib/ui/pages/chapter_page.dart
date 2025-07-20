import 'package:flutter/material.dart';
import 'package:insightviewer/core/app_chapter.dart';
import 'package:insightviewer/ui/widgets/base_scaffold.dart';

class ChapterPage<T> extends StatefulWidget {
  final AppChapter chapter;
  final Future<T> Function(int chapterId) fetcher;
  final Widget Function(BuildContext context, T data) builder;

  const ChapterPage({
    super.key,
    required this.chapter,
    required this.fetcher,
    required this.builder,
  });

  @override
  State<ChapterPage<T>> createState() => _ChapterPageState<T>();
}

class _ChapterPageState<T> extends State<ChapterPage<T>> {
  late Future<T> _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = widget.fetcher(widget.chapter.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: _futureData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return BaseDataCategoryPageScaffold(
            chapter: widget.chapter,
            body: Center(child: Text("Could not load data ${snapshot.error}")),
          );
        }
        final data = snapshot.data;
        if (data == null) {
          return BaseDataCategoryPageScaffold(
            chapter: widget.chapter,
            body: Center(child: Text("No data available")),
          );
        }
        return BaseDataCategoryPageScaffold(
          chapter: widget.chapter,
          body: widget.builder(context, data),
        );
      },
    );
  }
}
