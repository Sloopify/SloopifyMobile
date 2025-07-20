import 'package:sloopify_mobile/features/chat_friend/utils/enums/message_type.dart';

class MessageModel {
  final String id;
  final String text;
  final String time;
  final bool isMe;
  final MessageType type;
  final String? mediaUrl;
  final bool isOneTime; // ✅ Already included, preserved.

  // 🆕 Optional additions (fully backward-compatible)
  final Duration? duration;
  final bool isPlayed; // for one-time audio
  final bool isViewed; // for one-time photo

  MessageModel({
    required this.id,
    required this.text,
    required this.time,
    required this.isMe,
    required this.type,
    this.mediaUrl,
    this.isOneTime = false,
    this.duration,
    this.isPlayed = false,
    this.isViewed = false,
  });

  MessageModel copyWith({
    String? id,
    String? text,
    String? time,
    bool? isMe,
    MessageType? type,
    String? mediaUrl,
    bool? isOneTime,
    Duration? audioDuration,
    bool? isPlayed,
    bool? isViewed,
  }) {
    return MessageModel(
      id: id ?? this.id,
      text: text ?? this.text,
      time: time ?? this.time,
      isMe: isMe ?? this.isMe,
      type: type ?? this.type,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      isOneTime: isOneTime ?? this.isOneTime,
      duration: audioDuration ?? duration,
      isPlayed: isPlayed ?? this.isPlayed,
      isViewed: isViewed ?? this.isViewed,
    );
  }
}
