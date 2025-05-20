import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/features/chat_system/domain/entities/message_entity.dart';
import 'package:sloopify_mobile/features/chat_system/domain/entities/message_user_entity.dart';

import 'messages_state.dart';

part 'messages_event.dart';

class MessagesBloc extends Bloc<MessagesEvent, GetMessageState> {
  MessagesBloc() : super(GetMessageState.empty()) {
    on<LoadMessageEvent>((event, emit) async {
      emit(state.copyWith(status: GetMessageStatus.loading));
      await Future.delayed(Duration(seconds: 1));
      List<MessageEntity> messages = [
        MessageEntity(
          id: '1',
          anotherPersonProfileImage: AssetsManager.manExample2,
          message: "Hey! How are you?",
          messageDateTime: DateTime.now(),
          messagesNum: 4,
          receiverUserId: "receiver1",
          senderName: "Fadi",
          senderUserId: "sender1",
        ),
        MessageEntity(
          id: '2',
          anotherPersonProfileImage: AssetsManager.manExample2,
          message: "Hiii nour",
          messageDateTime: DateTime.now(),
          messagesNum: 5,
          receiverUserId: "receiver2",
          senderName: "Ibrahim",
          senderUserId: "sender2",
        ),
        MessageEntity(
          id: '2',
          anotherPersonProfileImage: AssetsManager.manExample2,
          message: "Hiii nour",
          messageDateTime: DateTime.now(),
          messagesNum: 5,
          receiverUserId: "receiver2",
          senderName: "Ibrahim",
          senderUserId: "sender2",
        ),
        MessageEntity(
          id: '2',
          anotherPersonProfileImage: AssetsManager.manExample2,
          message: "Hiii nour",
          messageDateTime: DateTime.now(),
          messagesNum: 5,
          receiverUserId: "receiver2",
          senderName: "Ibrahim",
          senderUserId: "sender2",
        ),
        MessageEntity(
          id: '2',
          anotherPersonProfileImage: AssetsManager.manExample2,
          message: "Hiii nour",
          messageDateTime: DateTime.now(),
          messagesNum: 5,
          receiverUserId: "receiver2",
          senderName: "Ibrahim",
          senderUserId: "sender2",
        ),
      ];

      emit(state.copyWith(data: messages, status: GetMessageStatus.success));
    });

    on<LoadChatMessageUser>((event, emit) async {
    });
    on<SendMessage>((event, emit) async {
      MessageUserEntity messageUserEntity = MessageUserEntity(
        senderUserId: event.userId,
        receiverUserId: event.receiverUserId,
        id: 'id',
        message: event.message,
        status: '',
        isRead: true,
        isRemoved: false,
        isMe: true,
        sendingNow: true,
        messageDateTime: DateTime.now(),
      );
      List<MessageUserEntity> data = List.generate(
        state.chatMessages.length,
        (index) => state.chatMessages[index],
      );

      data.insert(data.length, messageUserEntity);
      emit(
        state.copyWith(chatMessages: data, submitStatus: SubmitStatus.loading),
      );
      await Future.delayed(Duration(milliseconds: 500));
      emit(
        state.copyWith(chatMessages: data, submitStatus: SubmitStatus.success),
      );
    });
  }
}
