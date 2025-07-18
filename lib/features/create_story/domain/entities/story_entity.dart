import 'package:equatable/equatable.dart';
import 'package:sloopify_mobile/core/utils/helper/app_extensions/stoty_audience_extension.dart';
import 'package:sloopify_mobile/features/create_story/domain/entities/positioned_element_entity.dart';
import 'package:sloopify_mobile/features/create_story/domain/entities/text_properties_story.dart';
import 'package:sloopify_mobile/features/create_story/presentation/screens/story_audience/choose_story_audience.dart';

import 'all_positioned_element.dart';
import 'media_story.dart';

class StoryEntity extends Equatable {
  final String content;
  final PositionedTextElement? positionedTextElement;
  final List<String>? backgroundColor;
  final StoryAudience privacy;
  final List<int>? specificFriends;
  final List<int>? friendExcept;
  final PositionedElementWithLocationId? locationElement;
  final List<PositionedMentionElement>? mentionsElements;
  final PositionedElement? clockElement;
  final FeelingElement? feelingElement;
  final TemperatureElement? temperatureElement;
  final AudioElement? audioElement;
  final PollElement? pollElement;
  final StickerElement ? stickerElement;
  final List<MediaStory>? mediaFiles;
  final List<DrawingElement>? lines;

  const StoryEntity({
    required this.content,
    this.positionedTextElement,
    this.backgroundColor,
    required this.privacy,
    this.specificFriends,
    this.friendExcept,
    this.locationElement,
    this.mentionsElements,
    this.clockElement,
    this.feelingElement,
    this.temperatureElement,
    this.audioElement,
    this.pollElement,
    this.mediaFiles,
    this.stickerElement,
    this.lines
  });

  factory StoryEntity.fromEmpty() {
    return const StoryEntity(
      content: "",
      positionedTextElement: null,
      backgroundColor: null,
      privacy: StoryAudience.public,
      specificFriends: null,
      friendExcept: null,
      locationElement: null,
      mentionsElements: null,
      clockElement: null,
      feelingElement: null,
      temperatureElement: null,
      audioElement: null,
      pollElement: null,
      stickerElement: null,
      lines: [],
      mediaFiles: []
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    pollElement,
    audioElement,
    temperatureElement,
    feelingElement,
    clockElement,
    mentionsElements,
    locationElement,
    friendExcept,
    specificFriends,
    privacy,
    backgroundColor,
    stickerElement,
    positionedTextElement,
    content,
    mediaFiles,
    lines
  ];

  Future<Map<String, dynamic>> toJson() async {
    final Map<String, dynamic> data = {
      'content': content,
      'privacy': privacy.getValueForApi(),
    };
    if (positionedTextElement != null) {
      data['text_element'] = positionedTextElement!.toJson();
    }
    if (backgroundColor != null && backgroundColor!.isNotEmpty) {
      data['background_color'] = backgroundColor;
    }
    if (specificFriends != null && specificFriends!.isNotEmpty) {
      data['specific_friends'] = specificFriends;
    }
    if (friendExcept != null && friendExcept!.isNotEmpty) {
      data['friend_except'] = friendExcept;
    }
    if (locationElement != null) {
      data['location_element'] = locationElement!.toJson();
    }
    if (mentionsElements != null && mentionsElements!.isNotEmpty) {
      data['mentions_elements'] = mentionsElements!.map((e) =>
          e.toJson()).toList();
    }
    if (clockElement != null) {
      data['clock_element'] = clockElement!.toJson();
    }
    if (feelingElement != null) {
      data['feeling_element'] = feelingElement!.toJson();
    }
    if (temperatureElement != null) {
      data['temperature_element'] = temperatureElement!.toJson();
    }
    if (audioElement != null) {
      data['audio_element'] = audioElement!.toJson();
    }
    if (pollElement != null) {
      data['poll_element'] = pollElement!.toJson();
    }
    if (stickerElement != null) {
      data['gif_element'] = stickerElement!.toJson();
    }
    if (lines != null) {
      data['drawing_elements'] = lines!.map((e)=>e.toJson()).toList();
    }
    if (mediaFiles != null) {
      // Wait for all media files to be converted to JSON
      final mediaList = await Future.wait(mediaFiles!.map((e) => e.toJson()));
      data['media'] = mediaList;
    }
    return data;
  }
}
