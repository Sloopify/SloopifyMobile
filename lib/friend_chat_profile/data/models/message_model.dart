enum MessageType { text, image, audio }

class Message {
  final String id;
  final String senderName;
  final String content;
  final DateTime timestamp;
  final MessageType type;
  final Message? repliedTo;

  Message({
    required this.id,
    required this.senderName,
    required this.content,
    required this.timestamp,
    this.type = MessageType.text,
    this.repliedTo,
  });
}
