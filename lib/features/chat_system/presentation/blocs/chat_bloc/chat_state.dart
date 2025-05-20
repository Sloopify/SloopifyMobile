import 'package:sloopify_mobile/features/chat_system/domain/entities/message_user_entity.dart';

abstract class ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final List<MessageUserEntity> messages;
  final bool hasMore;
  final bool isLoadingMore;

  ChatLoaded({
    required this.messages,
    required this.hasMore,
    this.isLoadingMore = false,
  });

  ChatLoaded copyWith({
    List<MessageUserEntity>? messages,
    bool? hasMore,
    bool? isLoadingMore,
  }) {
    return ChatLoaded(
      messages: messages ?? this.messages,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

class ChatError extends ChatState {
  final String message;
  ChatError(this.message);
}
