import 'dart:convert';

import 'package:app_client/models/section.dart';
import 'package:http/http.dart' as http;

class DataRepository {
  static const String baseUrl = "http://192.168.1.6/ui-data";

  Future<Section> fetchStrategySection() async {
    final response = await http.get(Uri.parse("$baseUrl?chapterId=1"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Section.fromJson(data);
    } else {
      throw Exception("Failed to load section");
    }
  }

  Future<Section> fetchEconomicSection() async {
    final response = await http.get(Uri.parse(("$baseUrl?chapterId=3")));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Section.fromJson(data);
    } else {
      throw Exception("Failed to load section");
    }
  }

  Future<Section> fetchTeachingSection() async {
    final response = await http.get(Uri.parse(("$baseUrl?chapterId=4")));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Section.fromJson(data);
    } else {
      throw Exception("Failed to load section");
    }
  }
}
