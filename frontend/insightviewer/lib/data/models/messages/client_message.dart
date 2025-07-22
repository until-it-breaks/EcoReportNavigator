class ClientMessage {
  final int chapterId;
  final String? text;
  final bool freechat;
  final String? topicKey;

  ClientMessage({
    required this.chapterId,
    this.text,
    required this.freechat,
    this.topicKey,
  });

  Map<String, dynamic> toJson() {
    return {
      "chapterId": chapterId,
      "text": text,
      "freechat": freechat,
      "topicKey": topicKey,
    };
  }
}
