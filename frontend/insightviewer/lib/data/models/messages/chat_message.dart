enum ChatRole { user, bot }

class ChatMessage {
  final ChatRole role;
  final String text;
  final String? chartUrl;

  ChatMessage({required this.role, required this.text, this.chartUrl});
}
