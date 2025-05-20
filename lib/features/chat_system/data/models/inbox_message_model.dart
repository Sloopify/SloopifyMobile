import 'package:sloopify_mobile/features/chat_system/domain/entities/inbox_message_entity.dart';

class InboxMessageModel extends InboxMessageEntity {
  InboxMessageModel({
    required super.message,
    required super.numOfMessage,
    required super.senderId,
    required super.senderName,
    required super.senderProfileImage,
    required super.messageTimeStamp,
  });
}
