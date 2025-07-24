// lib/features/friend_chat_profile/domain/entities/message.dart

enum MessageType { text, image, audio }

class Message {
  final String id;
  final String senderId;
  final String content;
  final DateTime timestamp;
  final MessageType type;
  final Message? repliedTo;

  Message({
    required this.id,
    required this.senderId,
    required this.content,
    required this.timestamp,
    this.type = MessageType.text,
    this.repliedTo,
  });
}
