import '../../domain/entities/message_user_entity.dart';

class MessageUserModel extends MessageUserEntity {
  MessageUserModel({required super.isRead,
    required super.message,
    required super.id,
    required super.receiverUserId,
    required super.senderUserId,
    required super.status,
    required super.isRemoved,
    required super.isMe,
    required super.sendingNow,
    required super.messageDateTime});
}