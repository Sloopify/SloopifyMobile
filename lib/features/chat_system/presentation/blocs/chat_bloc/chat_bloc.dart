import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/features/chat_system/domain/entities/message_user_entity.dart';

import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  List<MessageUserEntity> _allMessages = [];
  int _page = 0;
  final int _pageSize = 20;

  ChatBloc() : super(ChatLoading()) {
    on<FetchInitialMessages>((event, emit) async {
      _page = 0;
      _allMessages.clear();
      final messages = await _fetchMessages2(_page);
      _allMessages.addAll(messages);
      emit(
        ChatLoaded(
          messages: _allMessages,
          hasMore: messages.length == _pageSize,
        ),
      );
    });
    on<SendMessage>((event, emit) {
      _allMessages.insert(0, event.messageUserEntity);
      if (state is ChatLoaded) {
        final current = state as ChatLoaded;
        emit(current.copyWith(messages: List.from(_allMessages)));
      } else {
        emit(ChatLoaded(messages: _allMessages, hasMore: false));
      }
    });
    on<FetchMoreMessages>((event, emit) async {
      if (state is! ChatLoaded) return;
      final current =state as ChatLoaded;
      emit(current.copyWith(isLoadingMore: true));
      _page++;
      final messages = await _fetchMessages2(_page);
      _allMessages.addAll(messages);
      emit(
        ChatLoaded(
          messages: _allMessages,
          hasMore: messages.length == _pageSize,
          isLoadingMore: false
        ),
      );
    });
  }

  Future<List<MessageUserEntity>> _fetchMessages(int page) async {
    await Future.delayed(Duration(seconds: 1)); // simulate server delay
    return List.generate(_pageSize, (index) {
      final id = (page * _pageSize + index).toString();
      return MessageUserEntity(
        isRead: false,
        isRemoved: false,
        receiverUserId: "",
        senderUserId: "",
        sendingNow: false,
        status: "",
        id: id,
        message: "Message $id",
        messageDateTime:
            DateTime.now()
                .subtract(Duration(minutes: id.hashCode % 1440)),
        isMe: id.hashCode % 2 == 0,
      );
    });
  }
  Future<List<MessageUserEntity>> _fetchMessages2(int page) async {
    await Future.delayed(Duration(seconds: 1)); // simulate server delay
    final now = DateTime.now();

    return List.generate(_pageSize, (index) {
      final id = (page * _pageSize + index).toString();

      // كل مجموعة 5 رسائل نغير التاريخ
      late DateTime timestamp;
      final groupIndex = index % 20;

      if (groupIndex < 5) {
        timestamp = now.subtract(Duration(minutes: groupIndex * 3)); // اليوم
      } else if (groupIndex < 10) {
        timestamp = now.subtract(Duration(days: 1, minutes: groupIndex * 3)); // أمس
      } else if (groupIndex < 15) {
        timestamp = now.subtract(Duration(days: 2, minutes: groupIndex * 4)); // قبل أمس
      } else {
        timestamp = now.subtract(Duration(days: 5 + groupIndex, minutes: 10)); // قديم
      }

      return MessageUserEntity(
        isRead: false,
        isRemoved: false,
        receiverUserId: "",
        senderUserId: "",
        sendingNow: false,
        status: "",
        id: id,
        message: "رسالة $id",
        messageDateTime: timestamp,
        isMe: id.hashCode % 2 == 0,
      );
    });
  }
}
