import 'dart:convert';

import 'package:app_client/models/section.dart';
import 'package:http/http.dart' as http;

class DataRepository {
  static const String baseUrl = "http://192.168.1.6/ui-data";

  Future<Section> fetchSection(ChapterEnum chapter) async {
    final response = await http.get(
      Uri.parse("$baseUrl?chapterId=${chapter.id}"),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Section.fromJson(data);
    } else {
      throw Exception(
        "Failed to load [${chapter.name}] section with chapterId [${chapter.id}]",
      );
    }
  }
}

enum ChapterEnum {
  strategy(1),
  economic(3),
  teaching(4),
  research(5),
  people(6),
  society(7),
  environment(8);

  final int id;
  const ChapterEnum(this.id);
}
