import 'package:sloopify_mobile/features/story_view/domain/entities/story_view_entity.dart';

class StoryViewModel extends StoryViewEntity {
  StoryViewModel({
    super.audioElement,
    super.backgroundColor,
      super.clockElement,
    super.drawingElements,
    super.feelingElement,
    super.gifElement,
    super.locationElement,
    super.media,
    super.textElements,
    super.textElement,
    super.temperatureElement,
    super.pollResults,
    super.mentionsElements,
    super.pollElement,
    required super.specificFriends,
    required super.friendExcept,
    required super.storyUser,
    required super.createdAt,
    required super.isExpired,
    required super.isVideoMuted,
    required super.isStoryMutedNotification,
    required super.privacy,
    required super.expiresAt,
    required super.hasViewed,
    required super.id,
    required super.hasVoted,
    required super.repliesCount,
    required super.viewsCount,
  });
  

}
