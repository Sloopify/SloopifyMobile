import 'package:equatable/equatable.dart';
enum MessageUser { me, other }

class MessageUserEntity extends Equatable {
  final String id;
  final String senderUserId;
  final String receiverUserId;
  final bool isMe;
  final String message;
  final bool isRead;
  final bool isRemoved;
  final String status;
  final bool sendingNow;
  final DateTime messageDateTime;

  MessageUserEntity(
      {required this.isRead,
        required this.messageDateTime,
        required this.message,
        required this.id,
        required this.receiverUserId,
        required this.senderUserId,
        required this.status,
        required this.isRemoved,
        required this.sendingNow,
        required this.isMe});

  @override
  List<Object?> get props => [
    isRead,
    message,
    id,
    receiverUserId,
    senderUserId,
    status,
    isRemoved,
    isMe,
    sendingNow,
    messageDateTime
  ];

  MessageUserEntity copyWith({
    String? id,
    String? senderUserId,
    String? receiverUserId,
    bool? isMe,
    String? message,
    bool? isRead,
    bool? isRemoved,
    String? status,
    bool? sendingNow,
    DateTime? messageDateTime
  }) {
    return MessageUserEntity(
        id: id ?? this.id,
        message: message ?? this.message,
        receiverUserId: receiverUserId ?? this.receiverUserId,
        senderUserId: senderUserId ?? this.senderUserId,
        isRead: isRead ?? this.isRead,
        sendingNow: sendingNow ?? this.sendingNow,
        isMe: isMe ?? this.isMe,
        isRemoved: isRemoved ?? this.isRemoved,
        messageDateTime: messageDateTime?? this.messageDateTime,
        status: status ?? this.status);
  }
}
