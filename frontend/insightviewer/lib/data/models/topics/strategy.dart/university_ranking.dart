class UniversityRanking {
  final String name;
  final int positionInItaly;
  final int? positionInTheWorld;
  final String? comment;

  UniversityRanking({
    required this.name,
    required this.positionInItaly,
    this.positionInTheWorld,
    this.comment,
  });

  factory UniversityRanking.fromJson(Map<String, dynamic> json) {
    return UniversityRanking(
      name: json["nome"],
      positionInItaly: json["posizione_italia"],
      positionInTheWorld: json["posizione_mondo"],
      comment: json["commento"],
    );
  }

  static List<UniversityRanking> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((item) => UniversityRanking.fromJson(item)).toList();
  }
}
