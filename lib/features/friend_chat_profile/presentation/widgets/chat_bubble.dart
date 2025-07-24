import 'package:flutter/material.dart';
import 'package:sloopify_mobile/features/friend_chat_profile/data/models/message_model.dart';
import 'package:sloopify_mobile/features/friend_chat_profile/presentation/widgets/ImagePreviewBubble.dart';
import 'package:sloopify_mobile/features/friend_chat_profile/presentation/widgets/ReplyToContext.dart';
import 'package:sloopify_mobile/features/friend_chat_profile/presentation/widgets/VoiceMessageBubble.dart';

class ChatBubble extends StatelessWidget {
  final Message message;
  final bool isMe;

  const ChatBubble({required this.message, required this.isMe, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        if (message.repliedTo != null)
          ReplyToContext(repliedMessage: message.repliedTo!),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 6),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isMe ? Colors.teal[300] : Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (message.type == MessageType.text) Text(message.content),
              if (message.type == MessageType.image)
                ImagePreviewBubble(imageUrl: message.content),
              if (message.type == MessageType.audio)
                VoiceMessageBubble(audioUrl: message.content),
              Text(
                message.timestamp as String,
                style: TextStyle(fontSize: 10, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
