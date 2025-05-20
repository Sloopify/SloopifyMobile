import 'package:sloopify_mobile/features/chat_system/domain/entities/message_user_entity.dart';

abstract class ChatEvent {}

class FetchInitialMessages extends ChatEvent {}

class FetchMoreMessages extends ChatEvent {}

class SendMessage extends ChatEvent{
final MessageUserEntity messageUserEntity;
  SendMessage({required this.messageUserEntity});
}