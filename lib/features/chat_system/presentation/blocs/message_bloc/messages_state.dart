import 'package:equatable/equatable.dart';
import 'package:sloopify_mobile/features/chat_system/domain/entities/message_user_entity.dart';

import '../../../domain/entities/message_entity.dart';

enum GetMessageStatus { loading, loadingMore, success, offline, error }

enum GetChatMessageUserStatus { loading, success, offline, error }

enum SubmitStatus { init, loading, success, offline, error }

class GetMessageState extends Equatable {
  final GetMessageStatus status;
  final GetChatMessageUserStatus getChatMessageUserStatus;
  final List<MessageEntity> data;
  final List<MessageUserEntity> chatMessages;
  final SubmitStatus submitStatus;
  final int start;
  final bool hasReachedMax;
  final String errorMessage;

  GetMessageState({
    this.status = GetMessageStatus.loading,
    this.getChatMessageUserStatus = GetChatMessageUserStatus.loading,
    required this.chatMessages,
    this.hasReachedMax = false,
    this.data = const [],
    this.start = 0,
    this.submitStatus = SubmitStatus.init,
    this.errorMessage = "",
  });

  factory GetMessageState.empty() {
    return GetMessageState(
      chatMessages: [],
      status: GetMessageStatus.loading,
      start: 0,
      data: const [],
      errorMessage: '',
      submitStatus: SubmitStatus.init,
      getChatMessageUserStatus: GetChatMessageUserStatus.loading,
      hasReachedMax: false,
    );
  }

  @override
  List<Object> get props => [
    status,
    hasReachedMax,
    start,
    data,
    errorMessage,
    getChatMessageUserStatus,
    chatMessages,
    submitStatus,
  ];

  GetMessageState copyWith({
    GetMessageStatus? status,
    List<MessageEntity>? data,
    int? start,
    bool? hasReachedMax,
    String? errorMessage,
    GetChatMessageUserStatus? getChatMessageUserStatus,
    SubmitStatus? submitStatus,
    List<MessageUserEntity>? chatMessages,
  }) {
    return GetMessageState(
      status: status ?? this.status,
      data: data ?? this.data,
      start: start ?? this.start,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
      getChatMessageUserStatus:
          getChatMessageUserStatus ?? this.getChatMessageUserStatus,
      chatMessages: chatMessages ?? this.chatMessages,
      submitStatus: submitStatus ?? this.submitStatus,
    );
  }
}
