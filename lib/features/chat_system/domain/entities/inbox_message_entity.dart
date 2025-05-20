import 'package:equatable/equatable.dart';

class InboxMessageEntity extends Equatable {
  final String message;
  final String senderName;
  final int senderId;
  final int numOfMessage;
  final String senderProfileImage;
  final String messageTimeStamp;

  InboxMessageEntity({
    required this.message,
    required this.numOfMessage,
    required this.senderId,
    required this.senderName,
    required this.senderProfileImage,
    required this.messageTimeStamp
  });

  @override
  // TODO: implement props
  List<Object?> get props => [message,numOfMessage,senderName,senderId,senderProfileImage];
}
