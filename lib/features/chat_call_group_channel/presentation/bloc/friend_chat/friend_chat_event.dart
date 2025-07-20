import 'package:sloopify_mobile/features/chat_call_group_channel/data/models/friend_chat_message_model.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/presentation/bloc/friend_chat/friend_chat_state.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/utils/enums/message_type.dart';

abstract class ChatEvent {}

class SendMessageEvent extends ChatEvent {
  final String text;
  final MessageType type;
  final String? mediaUrl;

  SendMessageEvent({
    required this.text,
    this.type = MessageType.text,
    this.mediaUrl,
  });
}

class MuteChatEvent extends ChatEvent {
  final MuteDuration duration;
  MuteChatEvent(this.duration);
}

class UnmuteChatEvent extends ChatEvent {}

class SetReplyMessageEvent extends ChatEvent {
  final MessageModel message;
  SetReplyMessageEvent(this.message);
}

class PinMessageEvent extends ChatEvent {
  final MessageModel message;
  PinMessageEvent(this.message);
}

class UnpinMessageEvent extends ChatEvent {}

class StarMessageEvent extends ChatEvent {
  final MessageModel message;
  StarMessageEvent(this.message);
}

class ToggleStarMessageEvent extends ChatEvent {
  final String messageId;
  ToggleStarMessageEvent(this.messageId);
}

class DeleteMessagesEvent extends ChatEvent {
  final List<String> messageIds;
  DeleteMessagesEvent(this.messageIds);
}

class SearchStarredMessagesEvent extends ChatEvent {
  final String query;
  SearchStarredMessagesEvent(this.query);
}

class UnstarMessageEvent extends ChatEvent {
  final MessageModel message;
  UnstarMessageEvent(this.message);
}

class BlockUserEvent extends ChatEvent {}

class ReportUserEvent extends ChatEvent {
  final bool alsoBlock;
  ReportUserEvent({this.alsoBlock = false});
}
