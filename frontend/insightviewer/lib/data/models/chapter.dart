import 'package:insightviewer/data/models/topic.dart';

class Chapter {
  final int id;
  final String name;
  final Map<String, Topic> topics;

  Chapter({required this.id, required this.name, required this.topics});

  factory Chapter.fromJson(Map<String, dynamic> json) {
    final rawTopics = json["topics"] as Map<String, dynamic>;

    final topics = rawTopics.map(
      (key, value) =>
          MapEntry(key, Topic.fromJson(value as Map<String, dynamic>)),
    );

    return Chapter(id: json["numero"], name: json["nome"], topics: topics);
  }
}
