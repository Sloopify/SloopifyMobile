import 'package:equatable/equatable.dart';
import '../../domain/entities/media_item.dart';

class ChatMediaState extends Equatable {
  final Map<String, List<MediaItem>> mediaByDate;

  const ChatMediaState({required this.mediaByDate});

  factory ChatMediaState.initial() => const ChatMediaState(mediaByDate: {});

  ChatMediaState copyWith({Map<String, List<MediaItem>>? mediaByDate}) {
    return ChatMediaState(mediaByDate: mediaByDate ?? this.mediaByDate);
  }

  @override
  List<Object?> get props => [mediaByDate];
}
