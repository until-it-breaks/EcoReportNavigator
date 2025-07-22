class ServerMessage {
  final String reply;
  final String? chartUrl;

  ServerMessage({required this.reply, this.chartUrl});

  factory ServerMessage.fromJson(Map<String, dynamic> json) {
    return ServerMessage(
      reply: json['reply'] ?? '',
      chartUrl: json['chart_url'],
    );
  }
}
