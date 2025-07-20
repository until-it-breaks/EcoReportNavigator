class TopicMetadata {
  final String key;
  final String label;
  final String description;

  TopicMetadata({
    required this.key,
    required this.label,
    required this.description,
  });

  factory TopicMetadata.fromJson(Map<String, dynamic> json) {
    return TopicMetadata(
      key: json["key"],
      label: json["label"],
      description: json["description"],
    );
  }

  static List<TopicMetadata> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((item) => TopicMetadata.fromJson(item)).toList();
  }
}
