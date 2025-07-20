class SocialEvent {
  final String name;
  final int amount;

  SocialEvent({required this.name, required this.amount});

  factory SocialEvent.fromJson(Map<String, dynamic> json) {
    return SocialEvent(name: json["tipologia"], amount: json["numero_eventi"]);
  }

  static List<SocialEvent> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((item) => SocialEvent.fromJson(item)).toList();
  }
}
