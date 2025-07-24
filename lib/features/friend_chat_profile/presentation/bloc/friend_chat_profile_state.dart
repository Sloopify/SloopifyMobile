import 'package:sloopify_mobile/features/friend_chat_profile/domain/entities/message.dart';

class FriendProfileState {
  final List<Message> messages;
  final Message? replyingTo;

  FriendProfileState({required this.messages, this.replyingTo});
}
