// friend_chat_profile_event.dart
import 'package:sloopify_mobile/features/friend_chat_profile/domain/entities/message.dart';

abstract class FriendProfileEvent {}

class LoadFriendProfile extends FriendProfileEvent {}

class SendMessage extends FriendProfileEvent {
  final String message;
  final Message? replyingTo;

  SendMessage({required this.message, this.replyingTo});
}

class SelectReplyMessage extends FriendProfileEvent {
  final Message message;

  SelectReplyMessage(this.message);
}
