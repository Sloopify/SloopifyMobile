import 'package:equatable/equatable.dart';
import 'package:sloopify_mobile/core/utils/helper/app_extensions/stoty_audience_extension.dart';
import 'package:sloopify_mobile/features/create_story/domain/entities/positioned_element_entity.dart';
import 'package:sloopify_mobile/features/create_story/domain/entities/text_properties_story.dart';
import 'package:sloopify_mobile/features/create_story/presentation/screens/story_audience/choose_story_audience.dart';

import 'all_positioned_element.dart';
import 'media_story.dart';

class StoryEntity extends Equatable {
  final List<PositionedTextElement>? positionedTextElements;
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
  final StickerElement? stickerElement;
  final List<MediaStory>? mediaFiles;
  final List<DrawingElement>? lines;
  final bool? isVideoMuted;
  final PositionedTextElement? positionedTextElement;

  const StoryEntity({
    this.positionedTextElements,
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
    this.lines,
    this.isVideoMuted,
    this.positionedTextElement
  });

  factory StoryEntity.fromEmpty() {
    return const StoryEntity(
      positionedTextElements: [],
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
      mediaFiles: [],
      isVideoMuted: null,
      positionedTextElement: null
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props =>
      [
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
        positionedTextElements,
        mediaFiles,
        lines,
        isVideoMuted,
        positionedTextElement
      ];

  Future<Map<String, dynamic>> toJson() async {
    final Map<String, dynamic> data = {'privacy': privacy.getValueForApi()};
    if (isVideoMuted != null &&
        mediaFiles != null &&
        mediaFiles!.length == 1 &&
        mediaFiles!.first.isVideoFile == true) {
      data.putIfAbsent('isVideoMuted', () => boolToInt(isVideoMuted));
    }
    if (positionedTextElements != null && positionedTextElements!.isNotEmpty) {
      if (mediaFiles == null || mediaFiles!.isEmpty) {
        data['text_elements'] =
            positionedTextElements!.map((e) => e.toJson()).toList();
      } else {
        List<PositionedTextElement> positionedTextElement =
        positionedTextElements!;
        for (int i = 0; i < positionedTextElement.length; i++) {
          data["text_elements[$i]"] = positionedTextElement[i];
        }
      }
    }
    if(positionedTextElement!=null){
      data["text_element"]= positionedTextElement!.toJson();
    }
    if (backgroundColor != null &&
        backgroundColor!.isNotEmpty &&
        (mediaFiles == null || mediaFiles!.isEmpty)) {
      data['background_color'] = backgroundColor;
    }
    if (specificFriends != null && specificFriends!.isNotEmpty) {
      if (mediaFiles == null || mediaFiles!.isEmpty) {
        data['specific_friends'] = specificFriends;
      } else {
        List<int> specificFriendsList = specificFriends!;
        for (int i = 0; i < specificFriendsList.length; i++) {
          data["specific_friends[$i]"] = specificFriendsList[i];
        }
      }
    }
    if (friendExcept != null && friendExcept!.isNotEmpty) {
      if (mediaFiles == null || mediaFiles!.isEmpty) {
        data['friend_except'] = friendExcept;
      } else {
        List<int> friendsExceptList = friendExcept!;
        for (int i = 0; i < friendsExceptList.length; i++) {
          data["friend_except[$i]"] = friendsExceptList[i];
        }
      }
    }
    if ( locationElement!=null) {
      data['location_element'] = locationElement!.toJson();
    }
    if (mentionsElements != null && mentionsElements!.isNotEmpty) {
      if (mediaFiles == null || mediaFiles!.isEmpty) {
        data['mentions_elements'] =
            mentionsElements!.map((e) => e.toJson()).toList();
      } else {
        List<PositionedElement> mentions = mentionsElements!;
        for (int i = 0; i < mentions.length; i++) {
          data["mentions_elements[$i]"] = mentions[i];
        }
      }
    }
    if (clockElement != null ) {
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
        if (mediaFiles == null || mediaFiles!.isEmpty) {
          data['drawing_elements'] = lines!.map((e) => e.toJson()).toList();
        } else {
          List<DrawingElement> drawings = lines!;
          for (int i = 0; i < drawings.length; i++) {
            data["drawing_elements[$i]"] = drawings[i];
          }
        }
      }

    if (mediaFiles != null) {
      // Wait for all media files to be converted to JSON
      final mediaList = await Future.wait(mediaFiles!.map((e) => e.toJson()));
      data['media'] = mediaList;
    }
    return data;
  }
}


int boolToInt(bool? value) => (value ?? false) ? 1 : 0;
