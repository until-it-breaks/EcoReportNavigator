import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:insightviewer/core/app_chapter.dart';
import 'package:insightviewer/core/config.dart';
import 'package:insightviewer/data/data_repository.dart';
import 'package:insightviewer/data/models/messages/chat_message.dart';
import 'package:insightviewer/data/models/messages/client_message.dart';
import 'package:insightviewer/data/models/messages/server_message.dart';
import 'package:insightviewer/data/models/topic_metadata.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatBottomSheet extends StatefulWidget {
  final AppChapter chapter;
  final String sessionId;

  const ChatBottomSheet({
    super.key,
    required this.sessionId,
    required this.chapter,
  });

  @override
  State<ChatBottomSheet> createState() => _ChatBottomSheetState();
}

class _ChatBottomSheetState extends State<ChatBottomSheet> {
  late WebSocketChannel _channel;
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  bool _isLoading = false;

  List<TopicMetadata> _topics = [];

  @override
  void initState() {
    super.initState();

    _loadTopics();

    _channel = WebSocketChannel.connect(
      Uri.parse("${AppConfig.chatAPI}/${widget.sessionId}"),
    );

    _channel.stream.listen((data) {
      try {
        final Map<String, dynamic> jsonData = jsonDecode(data);
        final serverMessage = ServerMessage.fromJson(jsonData);

        setState(() {
          _isLoading = false;
          _messages.add(
            ChatMessage(
              role: ChatRole.bot,
              text: serverMessage.reply,
              chartUrl: serverMessage.chartUrl,
            ),
          );
        });
        WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
      } catch (e) {
        setState(() {
          _isLoading = false;
          _messages.add(
            ChatMessage(role: ChatRole.bot, text: "Failed to generate message"),
          );
        });
      }
    });
  }

  // Loads 5 random topics
  Future<void> _loadTopics() async {
    try {
      final topics = await DataRepository().fetchTopicMetadataList(
        widget.chapter,
      );
      setState(() {
        topics.shuffle();
        _topics = topics.take(5).toList();
      });
    } catch (e) {
      setState(() {
        _topics = [];
      });
    }
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      final msg = ClientMessage(
        chapterId: widget.chapter.id,
        text: text,
        freechat: true,
      );

      final jsonMsg = jsonEncode(msg);
      _channel.sink.add(jsonMsg);

      setState(() {
        _isLoading = true;
        _messages.add(ChatMessage(role: ChatRole.user, text: text));
        _controller.clear();
      });
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    }
  }

  void _sendTopicMessage(TopicMetadata topic) {
    final msg = ClientMessage(
      chapterId: widget.chapter.id,
      freechat: false,
      topicKey: topic.key,
    );

    final jsonMsg = jsonEncode(msg);
    _channel.sink.add(jsonMsg);

    setState(() {
      _isLoading = true;
      _messages.add(ChatMessage(role: ChatRole.user, text: topic.label));
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.3,
      maxChildSize: 1.00,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            color: theme.colorScheme.surface,
          ),
          child: Column(
            spacing: 8,
            children: [
              Row(
                spacing: 8,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.smart_toy, color: theme.colorScheme.primary),
                  const Text("AI Chatbot"),
                ],
              ),
              if (_topics.isNotEmpty) ...[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.start,
                    children:
                        _topics.map((topic) {
                          return ElevatedButton(
                            onPressed: () => _sendTopicMessage(topic),
                            child: Text(
                              topic.label,
                              style: theme.textTheme.bodySmall,
                            ),
                          );
                        }).toList(),
                  ),
                ),
              ],
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: _messages.length + (_isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (_isLoading && index == _messages.length) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            spacing: 8,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.smart_toy,
                                color: theme.colorScheme.primary,
                              ),
                              const CircularProgressIndicator(strokeWidth: 3),
                            ],
                          ),
                        ),
                      );
                    }

                    final message = _messages[index];
                    final isUser = message.role == ChatRole.user;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Align(
                        alignment:
                            isUser
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color:
                                isUser
                                    ? theme.colorScheme.primary.withAlpha(128)
                                    : theme.colorScheme.secondary.withAlpha(64),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(message.text),
                              if (message.chartUrl != null)
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder:
                                          (_) => Dialog(
                                            child: InteractiveViewer(
                                              child: Image.network(
                                                "${AppConfig.chartBaseUrl}${message.chartUrl}",
                                              ),
                                            ),
                                          ),
                                    );
                                  },
                                  child: Center(
                                    child: Image.network(
                                      "${AppConfig.chartBaseUrl}${message.chartUrl}",
                                      height: 200,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: "Chiedi qualcosa...",
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send, color: theme.colorScheme.primary),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
