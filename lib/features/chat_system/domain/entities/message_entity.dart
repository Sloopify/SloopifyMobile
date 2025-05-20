// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final String id;
  final String receiverUserId;
  final String senderUserId;
  final String message;
  final DateTime messageDateTime;
  final int messagesNum;
  final String anotherPersonProfileImage;
  final String senderName;


  MessageEntity({
    required this.id,
    required this.senderUserId,
    required this.receiverUserId,
    required this.message,
    required this.messageDateTime,
    required this.messagesNum,
    required this.anotherPersonProfileImage,
    required this.senderName
  });


  @override
  List<Object?> get props =>
      [id, receiverUserId, senderUserId, message, messageDateTime, messagesNum,anotherPersonProfileImage,senderName];

}
