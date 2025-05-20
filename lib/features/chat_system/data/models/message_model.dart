


import '../../domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  MessageModel({
    required super.id,
    required super.message,
    required super.receiverUserId,
    required super.senderUserId,
    required super.messageDateTime,
    required super.messagesNum, required super.anotherPersonProfileImage, required super.senderName
  });

  factory MessageModel.fromJson(Map<String, dynamic> map) {
    return MessageModel(
      senderName: '',
      anotherPersonProfileImage: map[''],
        id: map['Id'] as String,
        receiverUserId: map['ReceiverUserId'] as String,
        senderUserId: map['SenderUserId'] as String,
        message: map['Message'] as String,
        messagesNum: map['messagesNum'] ,
        messageDateTime: DateTime.parse( map['MessageDateTime'])

    );
  }
}
