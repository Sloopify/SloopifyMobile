import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/media_entity.dart';
import 'package:sloopify_mobile/features/create_story/domain/entities/all_positioned_element.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/story_editor_cubit/story_editor_cubit.dart';
import 'package:sloopify_mobile/features/create_story/presentation/screens/story_audience/choose_story_audience.dart';

import '../../../../create_posts/presentation/screens/post_audience_screen.dart';
import '../../../domain/entities/positioned_element_entity.dart';
import '../../../domain/entities/text_properties_story.dart';

class StoryEditorState extends Equatable {
  final List<AssetEntity> selectedMedia;
  final String content;
  final TextPropertiesForStory? textProperties;
  final List<MediaEntity>? mediaFiles;
  final List<String> backgroundColors;
  final List<PositionedElement> positionedElements;
  final PositionedElement? currentElement;
  final bool isVideoMuted;
  final StoryAudience privacy;
  final List<int> specificFriends;
  final List<int> friendExcept;
  final String? gifUrl;
  final List<DrawingElement> drawingElements;
  const StoryEditorState({
    this.selectedMedia=const [],
    this.content = "",
    this.textProperties,
    this.backgroundColors = const [],
    this.positionedElements = const [],
    this.isVideoMuted = false,
    this.privacy = StoryAudience.public,
    this.specificFriends = const [],
    this.friendExcept = const [],
    this.gifUrl,
    this.mediaFiles,
    this.drawingElements=const [],
    this.currentElement

  });
  StoryEditorState copyWith({
    List<AssetEntity>? selectedMedia,
    String? content,
    TextPropertiesForStory? textProperties,
    List<String>? backgroundColors,
    List<PositionedElement>? positionedElements,
    bool? isVideoMuted,
    StoryAudience? privacy,
    List<int>? specificFriends,
    List<int>? friendExcept,
    String? gifUrl,
    List<MediaEntity>? mediaFiles,
    List<DrawingElement> ?drawingElements,
    EditingMode? editingMode,
    bool ?isToolBarVisible,
    Color?drawingColor,
    double? drawingWidth,
    DrawingElement? currentLine,
    PositionedElement? currentOne

  }) {
    return StoryEditorState(
      selectedMedia: selectedMedia ?? this.selectedMedia,
      content: content ?? this.content,
      textProperties: textProperties ?? this.textProperties,
      backgroundColors: backgroundColors ?? this.backgroundColors,
      positionedElements: positionedElements ?? this.positionedElements,
      isVideoMuted: isVideoMuted ?? this.isVideoMuted,
      privacy: privacy ?? this.privacy,
      specificFriends: specificFriends ?? this.specificFriends,
      friendExcept: friendExcept ?? this.friendExcept,
      gifUrl: gifUrl ?? this.gifUrl,
      mediaFiles: mediaFiles??this.mediaFiles,
      drawingElements: drawingElements??this.drawingElements,
      currentElement: currentOne??currentElement

    );
  }
  @override
  List<Object?> get props => [
    selectedMedia,
    content,
    textProperties,
    backgroundColors,
    positionedElements,
    isVideoMuted,
    privacy,
    specificFriends,
    friendExcept,
    gifUrl,
    mediaFiles,
    drawingElements,
    currentElement

  ];
}
