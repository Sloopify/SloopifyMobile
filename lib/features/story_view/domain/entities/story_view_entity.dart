import 'package:equatable/equatable.dart';
import 'package:sloopify_mobile/features/create_story/domain/entities/all_positioned_element.dart';
import 'package:sloopify_mobile/features/create_story/domain/entities/media_story.dart';
import 'package:sloopify_mobile/features/create_story/domain/entities/positioned_element_entity.dart';
import 'package:sloopify_mobile/features/create_story/presentation/screens/story_audience/choose_story_audience.dart';
import 'package:sloopify_mobile/features/story_view/domain/entities/story_user_entity.dart';

class StoryViewEntity extends Equatable {
  final String id;
  final StoryUser storyUser;
  final String privacy;
  final List<int>? specificFriends;
  final List<int>? friendExcept;
  final List<PositionedTextElement>? textElements;
  final PositionedTextElement? textElement;
  final List<String>? backgroundColor;
  final List<PositionedMentionElement>? mentionsElements;
  final ClockElement? clockElement;
  final FeelingElement? feelingElement;
  final TemperatureElement? temperatureElement;
  final AudioElement? audioElement;
  final PollElement? pollElement;
  final PositionedElementWithLocationId? locationElement;
  final List<DrawingElement>? drawingElements;
  final StickerElement? gifElement;
  final bool isVideoMuted;
  final bool? isStoryMutedNotification;
  final List<MediaStory>? media;
  final int viewsCount;
  final int repliesCount;
  final bool hasViewed;
  final bool hasVoted;
  final dynamic pollResults;
  final DateTime expiresAt;
  final bool isExpired;
  final DateTime createdAt;

  StoryViewEntity({
    required this.specificFriends,
    required this.friendExcept,
    required this.storyUser,
    required this.createdAt,
    required this.isExpired,
    required this.isVideoMuted,
    required this.isStoryMutedNotification,
    this.temperatureElement,
    this.textElements,
    this.clockElement,
    this.locationElement,
    this.mentionsElements,
    this.drawingElements,
    this.media,
    this.audioElement,
    this.backgroundColor,
    this.feelingElement,
    this.gifElement,
    this.pollElement,
    this.pollResults,
    required this.privacy,
    required this.expiresAt,
    required this.hasViewed,
    required this.id,
    required this.hasVoted,
    required this.repliesCount,
    required this.viewsCount,
    this.textElement,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    viewsCount,
    repliesCount,
    hasVoted,
    id,
    hasViewed,
    expiresAt,
    privacy,
    pollResults,
    pollElement,
    gifElement,
    feelingElement,
    backgroundColor,
    audioElement,
    media,
    drawingElements,
    mentionsElements,
    locationElement,
    clockElement,
    textElements,
    specificFriends,
    friendExcept,
    storyUser,
    createdAt,
    isExpired,
    isVideoMuted,
    isStoryMutedNotification,
    temperatureElement,
    textElement,
  ];
  List<PositionedElement> getAllPositionedElements(){
    List<PositionedElement> allElements=[];
    if(temperatureElement!=null) allElements.add(temperatureElement!);
    if(clockElement!=null) allElements.add(clockElement!);
    if(locationElement!=null) allElements.add(locationElement!);
    if(mentionsElements!=null && mentionsElements!.isNotEmpty) allElements.addAll(mentionsElements!);
    if(audioElement!=null) allElements.add(audioElement!);
    if(pollElement!=null) allElements.add(pollElement!);
    if(feelingElement!=null) allElements.add(feelingElement!);
    if(gifElement!=null) allElements.add(gifElement!);
    return allElements;
  }
  StoryAudience getStoryPrivacyFromString(){
    switch(privacy){
      case "public":
        return StoryAudience.public;
      case "Friends":
        return StoryAudience.friends;
      case "Friends except":
        return StoryAudience.friendsExcept;
      case "Specific friends":
        return StoryAudience.specificFriends;
      default:
        return StoryAudience.public;
    }
  }


}
