import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/features/friend_chat_profile/data/models/user_model.dart';
import 'package:sloopify_mobile/features/friend_chat_profile/domain/entities/message.dart';
import 'package:sloopify_mobile/features/friend_chat_profile/presentation/bloc/friend_chat_profile_event.dart';
import 'package:sloopify_mobile/features/friend_chat_profile/presentation/bloc/friend_chat_profile_state.dart';

class FriendProfileBloc extends Bloc<FriendProfileEvent, FriendProfileState> {
  FriendProfileBloc()
    : super(FriendProfileState(messages: [], replyingTo: null)) {
    on<LoadFriendProfile>(_onLoadProfile);
    on<SelectReplyMessage>(_onSelectReplyMessage);
    on<SendMessage>(_onSendMessage);
  }

  Future<void> _onLoadProfile(
    LoadFriendProfile event,
    Emitter<FriendProfileState> emit,
  ) async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      // Dummy messages
      final messages = [
        Message(
          id: '1',
          senderId: 'user_1',
          content: 'Hello!',
          timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        ),
        Message(
          id: '2',
          senderId: 'user_2',
          content: 'Hey, what’s up?',
          timestamp: DateTime.now().subtract(const Duration(minutes: 3)),
        ),
      ];

      emit(FriendProfileState(messages: messages, replyingTo: null));
    } catch (_) {
      // You can optionally add an error state here
      emit(FriendProfileState(messages: [], replyingTo: null));
    }
  }

  void _onSelectReplyMessage(
    SelectReplyMessage event,
    Emitter<FriendProfileState> emit,
  ) {
    emit(
      FriendProfileState(messages: state.messages, replyingTo: event.message),
    );
  }

  void _onSendMessage(SendMessage event, Emitter<FriendProfileState> emit) {
    final newMessage = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: 'me',
      content: event.message,
      timestamp: DateTime.now(),
      repliedTo: event.replyingTo,
    );

    final updatedMessages = [...state.messages, newMessage];

    emit(FriendProfileState(messages: updatedMessages, replyingTo: null));
  }
}
