import 'dart:convert';

import 'package:insightviewer/core/app_chapter.dart';
import 'package:insightviewer/core/config.dart';
import 'package:insightviewer/data/models/chapter.dart';
import 'package:http/http.dart' as http;
import 'package:insightviewer/data/models/topic.dart';
import 'package:insightviewer/data/models/topic_metadata.dart';

class DataRepository {
  static final String baseUrl = AppConfig.dataAPI;

  Future<Chapter> fetchChapter(AppChapter chapter) async {
    final response = await http.get(Uri.parse("$baseUrl/${chapter.id}"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Chapter.fromJson(data);
    } else {
      throw Exception(
        "Failed to load [${chapter.name}] section with chapterId [${chapter.id}]",
      );
    }
  }

  Future<List<TopicMetadata>> fetchTopicMetadataList(AppChapter chapter) async {
    final url = "$baseUrl/${chapter.id}/topics";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return TopicMetadata.listFromJson(jsonData);
    } else {
      throw Exception(
        "Failed to load topic metadata list for chapter [${chapter.name}]",
      );
    }
  }

  Future<Topic> fetchTopic(AppChapter chapter, String topicKey) async {
    final url = "$baseUrl/${chapter.id}/topics/$topicKey";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return Topic.fromJson(jsonData);
    } else {
      throw Exception(
        "Failed to load topic [$topicKey] from chapter [${chapter.id}]",
      );
    }
  }
}
