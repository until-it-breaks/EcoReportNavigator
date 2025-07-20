class Topic {
  final String key;
  final String label;
  final String description;
  final Map<String, dynamic> data;

  Topic({
    required this.key,
    required this.label,
    required this.description,
    required this.data,
  });

  factory Topic.fromJson(Map<String, dynamic> json) {
    final rawData = json['data'] as Map<String, dynamic>;

    final data =
        Map<String, dynamic>.from(rawData)
          ..remove('label')
          ..remove('description');

    return Topic(
      key: json['key'] as String,
      label: rawData['label'] as String,
      description: rawData['description'] as String,
      data: data,
    );
  }
}
