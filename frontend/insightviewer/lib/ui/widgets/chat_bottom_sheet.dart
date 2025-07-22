import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:insightviewer/core/app_chapter.dart';
import 'package:insightviewer/core/config.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class IncomingMessage {
  final int chapterId;
  final String? text;
  final bool freechat;
  final String? topicKey;

  IncomingMessage({
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

class OutgoingMessage {
  final String reply;
  final String? chartUrl;

  OutgoingMessage({required this.reply, this.chartUrl});

  factory OutgoingMessage.fromJson(Map<String, dynamic> json) {
    return OutgoingMessage(
      reply: json['reply'] ?? '',
      chartUrl: json['chart_url'],
    );
  }
}

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
  final List<Map<String, String>> _messages = [];

  @override
  void initState() {
    super.initState();
    _channel = WebSocketChannel.connect(
      Uri.parse("${AppConfig.chatAPI}/${widget.sessionId}"),
    );
    _channel.stream.listen((data) {
      try {
        final Map<String, dynamic> jsonData = jsonDecode(data);
        final outgoing = OutgoingMessage.fromJson(jsonData);

        setState(() {
          _messages.add({
            "role": "bot",
            "msg": outgoing.reply,
            "chartUrl": outgoing.chartUrl ?? "null",
          });
        });
      } catch (e) {
        // If parsing fails, treat data as plain text fallback
        setState(() {
          _messages.add({"role": "bot", "msg": data});
        });
      }
    });
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      final msg = IncomingMessage(
        chapterId:
            widget.chapter.id, // assuming your chapter has an id property
        text: text,
        freechat: true, // or false depending on your logic
        topicKey: null, // or a specific topic key if you have one
      );

      final jsonMsg = jsonEncode(msg.toJson());
      _channel.sink.add(jsonMsg);

      setState(() {
        _messages.add({"role": "user", "msg": text});
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      builder: (context, scrollController) {
        return Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            color: Theme.of(context).colorScheme.surface,
          ),
          child: Column(
            children: [
              Text("AI Assistant"),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    final isUser = message["role"] == "user";
                    return Align(
                      alignment:
                          isUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color:
                              isUser
                                  ? Theme.of(
                                    context,
                                  ).colorScheme.primary.withValues(alpha: 0.1)
                                  : Theme.of(context).colorScheme.secondary
                                      .withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(message["msg"] ?? ""),
                            if (message["chartUrl"] != null) ...[
                              const SizedBox(height: 8),
                              Image.network(
                                "http://192.168.1.6${message["chartUrl"]}",
                              ),
                            ],
                          ],
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
                        hintText: "Ask something...",
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
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
