part of 'messages_bloc.dart';

@immutable
abstract class MessagesEvent {}

class LoadMessageEvent extends MessagesEvent {
  final bool refresh;
  final String userId;

  LoadMessageEvent({this.refresh = false, required this.userId});
}
class LoadChatMessageUser extends MessagesEvent {
  final String userId;
  final String receiverUserId;


  LoadChatMessageUser({required this.receiverUserId, required this.userId});
}
class SendMessage extends MessagesEvent {
  final String userId;
  final String message;
  final String receiverUserId;
  SendMessage({
    required this.userId,
    required this.message,
    required this.receiverUserId
  });
}