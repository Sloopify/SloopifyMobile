import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum MediaType {
  image,
  video,
  none,
}
abstract class StoryElement extends Equatable {
  final Offset position;
  final double rotation;
  final double scale;
  const StoryElement({
    this.position = Offset.zero,
    this.rotation = 0.0,
    this.scale = 1.0,
  });
  StoryElement copyWith({
    Offset? position,
    double? rotation,
    double? scale,
  });
  @override
  List<Object?> get props => [position, rotation, scale];
}
class StoryTextElement extends StoryElement {
  final String text;
  final TextStyle textStyle;
  final Color backgroundColor;
  const StoryTextElement({
    required this.text,
    super.position,
    super.rotation,
    super.scale,
    this.textStyle =const  TextStyle(fontSize: 24, color: Colors.white),
    this.backgroundColor = Colors.transparent,
  });
  @override
  StoryTextElement copyWith({
    String? text,
    TextStyle? textStyle,
    Color? backgroundColor,
    Offset? position,
    double? rotation,
    double? scale,
  }) {
    return StoryTextElement(
      text: text ?? this.text,
      textStyle: textStyle ?? this.textStyle,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      position: position ?? this.position,
      rotation: rotation ?? this.rotation,
      scale: scale ?? this.scale,
    );
  }
  @override
  List<Object?> get props => [
    ...super.props,
    text,
    textStyle,
    backgroundColor,
  ];
}
class StoryStickerElement extends StoryElement {
  final String stickerAssetPath;
  const StoryStickerElement({
    required this.stickerAssetPath,
    super.position,
    super.rotation,
    super.scale,
  });
  @override
  StoryStickerElement copyWith({
    String? stickerAssetPath,
    Offset? position,
    double? rotation,
    double? scale,
  }) {
    return StoryStickerElement(
      stickerAssetPath: stickerAssetPath ?? this.stickerAssetPath,
      position: position ?? this.position,
      rotation: rotation ?? this.rotation,
      scale: scale ?? this.scale,
    );
  }
  @override
  List<Object?> get props => [
    ...super.props,
    stickerAssetPath,
  ];
}
class StoryEmojiElement extends StoryElement {
  final String emoji;
  const StoryEmojiElement({
    required this.emoji,
    super.position,
    super.rotation,
    super.scale,
  });
  @override
  StoryEmojiElement copyWith({
    String? emoji,
    Offset? position,
    double? rotation,
    double? scale,
  }) {
    return StoryEmojiElement(
      emoji: emoji ?? this.emoji,
      position: position ?? this.position,
      rotation: rotation ?? this.rotation,
      scale: scale ?? this.scale,
    );
  }
  @override
  List<Object?> get props => [
    ...super.props,
    emoji,
  ];
}


