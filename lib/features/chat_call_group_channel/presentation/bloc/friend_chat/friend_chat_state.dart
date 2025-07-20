import 'package:sloopify_mobile/features/chat_call_group_channel/data/models/friend_chat_message_model.dart';

enum MuteDuration { none, hours24, days7, days30, untilUnmuted }

enum MessageSortType { newestFirst, oldestFirst, onlyMedia, onlyOneTime }

class ChatState {
  final bool isUserBlocked;
  final MessageModel? pinnedMessage;
  final MessageModel? replyingTo;
  final List<MessageModel> messages;
  final List<MessageModel> starredMessages;
  final bool isMuted;
  final MuteDuration muteDuration;

  // 🎤 Voice Recording
  final bool isRecording;
  final String? recordedFilePath;

  // 🔽 Message Sorting
  final MessageSortType sortType;

  // 🖼️ Image Preview
  final bool isPreviewingImage;
  final String? previewImagePath;

  // 🖼️ Multiple Gallery Selection
  final List<String> selectedGalleryImages;

  // 🔐 One-Time View Settings
  final bool isOneTimeView;
  final bool isPlayingOneTimeAudio;

  const ChatState({
    required this.messages,
    required this.starredMessages,
    required this.isUserBlocked,
    required this.pinnedMessage,
    required this.replyingTo,
    this.isMuted = false,
    this.muteDuration = MuteDuration.none,
    this.isRecording = false,
    this.recordedFilePath,
    this.sortType = MessageSortType.newestFirst,
    this.isPreviewingImage = false,
    this.previewImagePath,
    this.selectedGalleryImages = const [],
    this.isOneTimeView = false,
    this.isPlayingOneTimeAudio = false,
  });

  ChatState copyWith({
    List<MessageModel>? messages,
    List<MessageModel>? starredMessages,
    bool? isUserBlocked,
    MessageModel? pinnedMessage,
    MessageModel? replyingTo,
    bool? isMuted,
    MuteDuration? muteDuration,
    bool? isRecording,
    String? recordedFilePath,
    MessageSortType? sortType,
    bool? isPreviewingImage,
    String? previewImagePath,
    List<String>? selectedGalleryImages,
    bool? isOneTimeView,
    bool? isPlayingOneTimeAudio,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      starredMessages: starredMessages ?? this.starredMessages,
      isUserBlocked: isUserBlocked ?? this.isUserBlocked,
      pinnedMessage: pinnedMessage ?? this.pinnedMessage,
      replyingTo: replyingTo ?? this.replyingTo,
      isMuted: isMuted ?? this.isMuted,
      muteDuration: muteDuration ?? this.muteDuration,
      isRecording: isRecording ?? this.isRecording,
      recordedFilePath: recordedFilePath ?? this.recordedFilePath,
      sortType: sortType ?? this.sortType,
      isPreviewingImage: isPreviewingImage ?? this.isPreviewingImage,
      previewImagePath: previewImagePath ?? this.previewImagePath,
      selectedGalleryImages:
          selectedGalleryImages ?? this.selectedGalleryImages,
      isOneTimeView: isOneTimeView ?? this.isOneTimeView,
      isPlayingOneTimeAudio:
          isPlayingOneTimeAudio ?? this.isPlayingOneTimeAudio,
    );
  }
}
