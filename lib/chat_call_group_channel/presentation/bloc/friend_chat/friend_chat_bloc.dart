import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/data/models/friend_chat_message_model.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/presentation/bloc/friend_chat/friend_chat_event.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/presentation/bloc/friend_chat/friend_chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc()
    : super(
        const ChatState(
          messages: [],
          starredMessages: [],
          isUserBlocked: false,
          pinnedMessage: null,
          replyingTo: null,
        ),
      ) {
    // 📨 Send message (text or media)
    on<SendMessageEvent>((event, emit) {
      final newMessage = MessageModel(
        id: DateTime.now().toString(),
        text: event.text,
        time: _formatTime(DateTime.now()),
        isMe: true,
        type: event.type,
        mediaUrl: event.mediaUrl,
      );

      final updatedMessages = List<MessageModel>.from(state.messages)
        ..add(newMessage);

      emit(state.copyWith(messages: updatedMessages, replyingTo: null));
    });

    // 🎙️ Send audio message
    // on<SendAudioMessageEvent>((event, emit) {
    //   final audioMessage = MessageModel(
    //     id: DateTime.now().toString(),
    //     time: _formatTime(DateTime.now()),
    //     isMe: true,
    //     type: event.isOneTime ? MessageType.oneTimeAudio : MessageType.audio,
    //     mediaUrl: event.filePath,
    //     duration: event.duration,
    //   );

    //   final updatedMessages = List<MessageModel>.from(state.messages)
    //     ..add(audioMessage);

    //   emit(state.copyWith(messages: updatedMessages));
    // });

    // 🖼️ Send image/video/document message
    // on<SendMediaMessageEvent>((event, emit) {
    //   final mediaType =
    //       event.isOneTime
    //           ? (event.type == MessageType.image
    //               ? MessageType.oneTimeImage
    //               : event.type)
    //           : event.type;

    //   final mediaMessage = MessageModel(
    //     id: DateTime.now().toString(),
    //     time: _formatTime(DateTime.now()),
    //     isMe: true,
    //     type: mediaType,
    //     mediaUrl: event.filePath,
    //   );

    //   final updatedMessages = List<MessageModel>.from(state.messages)
    //     ..add(mediaMessage);

    //  emit(state.copyWith(messages: updatedMessages));
    // });

    // ↩️ Set reply message
    on<SetReplyMessageEvent>((event, emit) {
      emit(state.copyWith(replyingTo: event.message));
    });

    // ⭐ Star message
    on<StarMessageEvent>((event, emit) {
      final updatedStarred = List<MessageModel>.from(state.starredMessages)
        ..add(event.message);
      emit(state.copyWith(starredMessages: updatedStarred));
    });

    // ❌ Unstar message
    on<UnstarMessageEvent>((event, emit) {
      final updatedStarred = List<MessageModel>.from(state.starredMessages)
        ..removeWhere((msg) => msg.id == event.message.id);
      emit(state.copyWith(starredMessages: updatedStarred));
    });

    // 📌 Pin message
    on<PinMessageEvent>((event, emit) {
      emit(state.copyWith(pinnedMessage: event.message));
    });

    // 🚫 Unpin message
    on<UnpinMessageEvent>((event, emit) {
      emit(state.copyWith(pinnedMessage: null));
    });

    // 🚫 Block user
    on<BlockUserEvent>((event, emit) {
      emit(state.copyWith(isUserBlocked: true));
    });

    // 🚨 Report user (optional block)
    on<ReportUserEvent>((event, emit) {
      if (event.alsoBlock) {
        emit(state.copyWith(isUserBlocked: true));
      }
    });

    // 🔕 Mute chat
    on<MuteChatEvent>((event, emit) {
      emit(state.copyWith(isMuted: true, muteDuration: event.duration));
    });

    // 🔔 Unmute chat
    on<UnmuteChatEvent>((event, emit) {
      emit(state.copyWith(isMuted: false, muteDuration: MuteDuration.none));
    });
  }

  String _formatTime(DateTime dt) {
    return "${dt.hour}:${dt.minute.toString().padLeft(2, '0')}";
  }
}
