import 'dart:ui';

import 'package:sloopify_mobile/features/create_story/domain/positioned_element_entity.dart';
import 'package:sloopify_mobile/features/create_story/domain/text_properties_story.dart';

import '../../../core/utils/helper/postioned_element_story_theme.dart';

class PositionedElementWithLocationId extends PositionedElement {
  final int locationId;

  const PositionedElementWithLocationId({
    required this.locationId,
    required super.offset,
    required super.id,
    required super.rotation,
    required super.positionedElementStoryTheme,
    required super.size,
  });

  @override
  Map<String, dynamic> toJson() {
    return {'id': locationId, ...super.toJson()};
  }

  PositionedElementWithLocationId copyWith({
    int? locationId,
    PositionedElementStoryTheme? positionedElementStoryTheme,
    Offset? offset,
    Size? size,
    double? rotation,
  }) {
    return PositionedElementWithLocationId(
      rotation: rotation ?? this.rotation,
      id: id,
      locationId: locationId ?? this.locationId,
      offset: offset ?? this.offset,
      positionedElementStoryTheme:
      positionedElementStoryTheme ?? this.positionedElementStoryTheme,
      size: size ?? this.size,
    );
  }
}

class PositionedMentionElement extends PositionedElement {
  final int friendId;

  PositionedMentionElement({
    required this.friendId,
    required super.offset,
    required super.id,
    required super.rotation,
    required super.positionedElementStoryTheme,
    required super.size,
  });

  @override
  Map<String, dynamic> toJson() {
    return {'friend_id': friendId, ...super.toJson()};
  }

  PositionedMentionElement copyWith({
    int? friendId,
    PositionedElementStoryTheme? positionedElementStoryTheme,
    Offset? offset,
    Size? size,
    double? rotation,
  }) {
    return PositionedMentionElement(
      id: id,
      friendId: friendId ?? this.friendId,
      offset: offset ?? this.offset,
      rotation: rotation ?? this.rotation,
      positionedElementStoryTheme:
      positionedElementStoryTheme ?? this.positionedElementStoryTheme,
      size: size ?? this.size,
    );
  }
}

class PositionedTextElement extends PositionedElement {
  final TextPropertiesForStory textPropertiesForStory;
  final String text;

  PositionedTextElement({
    required this.textPropertiesForStory,
    required super.offset,
    required super.id,
    required super.rotation,
    required super.positionedElementStoryTheme,
    required super.size,
    required this.text
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'text_properties': textPropertiesForStory.toJson(),
      ...super.toJson()
    };
  }

  PositionedTextElement copyWith({
    PositionedElementStoryTheme? positionedElementStoryTheme,
    Offset? offset,
    Size? size,
    double? rotation,
    TextPropertiesForStory? textProperty,
    String ? text
  }) {
    return PositionedTextElement(
      text: text??this.text,
      textPropertiesForStory: textProperty ?? textPropertiesForStory,
      id: id,
      offset: offset ?? this.offset,
      rotation: rotation ?? this.rotation,
      positionedElementStoryTheme:
      positionedElementStoryTheme ?? this.positionedElementStoryTheme,
      size: size ?? this.size,
    );
  }
}

class FeelingElement extends PositionedElement {
  final int feelingId;

  FeelingElement({
    required this.feelingId,
    required super.offset,
    required super.positionedElementStoryTheme,
    required super.rotation,
    required super.id,
    required super.size,
  });

  @override
  Map<String, dynamic> toJson() {
    return {'feeling_id': feelingId, ...super.toJson()};
  }

  FeelingElement copyWith({
    int? feelingId,
    PositionedElementStoryTheme? positionedElementStoryTheme,
    Offset? offset,
    double? rotation,
    Size? size,
  }) {
    return FeelingElement(
      feelingId: feelingId ?? this.feelingId,
      rotation: rotation ?? this.rotation,
      offset: offset ?? this.offset,
      id: id,
      positionedElementStoryTheme:
      positionedElementStoryTheme ?? this.positionedElementStoryTheme,
      size: size ?? this.size,
    );
  }
}

class TemperatureElement extends PositionedElement {
  final double value;

  TemperatureElement({
    required this.value,
    required super.offset,
    required super.id,
    required super.rotation,
    required super.positionedElementStoryTheme,
    required super.size,
  });

  @override
  Map<String, dynamic> toJson() {
    return {'value': value, ...super.toJson()};
  }

  TemperatureElement copyWith({
    double? value,
    PositionedElementStoryTheme? positionedElementStoryTheme,
    Offset? offset,
    double? rotation,
    Size? size,
  }) {
    return TemperatureElement(
      id: id,
      value: value ?? this.value,
      offset: offset ?? this.offset,
      rotation: rotation ?? this.rotation,
      positionedElementStoryTheme:
      positionedElementStoryTheme ?? this.positionedElementStoryTheme,
      size: size ?? this.size,
    );
  }
}

class AudioElement extends PositionedElement {
  final int audioId;

  AudioElement({
    required this.audioId,
    required super.offset,
    required super.id,
    required super.rotation,
    required super.positionedElementStoryTheme,
    required super.size,
  });

  @override
  Map<String, dynamic> toJson() {
    return {'audio_id': audioId, ...super.toJson()};
  }

  AudioElement copyWith({
    double? value,
    PositionedElementStoryTheme? positionedElementStoryTheme,
    Offset? offset,
    double? rotation,
    Size? size,
    int? audioId,
  }) {
    return AudioElement(
      audioId: audioId ?? this.audioId,
      offset: offset ?? this.offset,
      rotation: rotation ?? this.rotation,
      id: id,
      positionedElementStoryTheme:
      positionedElementStoryTheme ?? this.positionedElementStoryTheme,
      size: size ?? this.size,
    );
  }
}

class PollElement extends PositionedElement {
  final String question;
  final List<String> options;

  PollElement({
    required this.question,
    required this.options,
    required super.offset,
    required super.id,
    required super.rotation,
    required super.positionedElementStoryTheme,
    required super.size,
  });

  @override
  Map<String, dynamic> toJson() {
    return {'question': question, 'options': options, ...super.toJson()};
  }

  PollElement copyWith({
    double? value,
    PositionedElementStoryTheme? positionedElementStoryTheme,
    Offset? offset,
    double? rotation,
    Size? size,
    String? question,
    List<String>? options,
  }) {
    return PollElement(
      options: options ?? this.options,
      question: question ?? this.question,
      offset: offset ?? this.offset,
      rotation: rotation ?? this.rotation,
      id: id,
      positionedElementStoryTheme:
      positionedElementStoryTheme ?? this.positionedElementStoryTheme,
      size: size ?? this.size,
    );
  }
}

class StickerElement extends PositionedElement {
  final String gifUrl;

  StickerElement({
    required this.gifUrl,
    required super.offset,
    required super.id,
    required super.rotation,
    required super.positionedElementStoryTheme,
    required super.size,
  });

  @override
  Map<String, dynamic> toJson() {
    return {'gif_url': gifUrl, ...super.toJson()};
  }

  StickerElement copyWith({
    PositionedElementStoryTheme? positionedElementStoryTheme,
    Offset? offset,
    double? rotation,
    Size? size,
    String? gifUrl,
  }) {
    return StickerElement(
      gifUrl: gifUrl ?? this.gifUrl,
      offset: offset ?? this.offset,
      rotation: rotation ?? this.rotation,
      id: id,
      positionedElementStoryTheme:
      positionedElementStoryTheme ?? this.positionedElementStoryTheme,
      size: size ?? this.size,
    );
  }
}

class ClockElement extends PositionedElement {
  final DateTime dateTime;
  final String theme;

  ClockElement({
    required super.offset,
    super.positionedElementStoryTheme,
    super.size,
    super.rotation,
    required super.id,
    required this.theme,
    required this.dateTime,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'x': offset?.dx,
      'y': offset?.dy,
      'theme': positionedElementStoryTheme?.getValuesForApi(),
      'size': size,
    };
  }

  ClockElement copyWith({
    PositionedElementStoryTheme? positionedElementStoryTheme,
    Offset? offset,
    Size? size,
    double? rotation,
    DateTime? time,
    String? theme,
  }) {
    return ClockElement(
      dateTime: time ?? dateTime,
      theme: theme ?? this.theme,
      id: id,
      offset: offset ?? this.offset,
      rotation: rotation ?? this.rotation,
      positionedElementStoryTheme:
      positionedElementStoryTheme ?? this.positionedElementStoryTheme,
      size: size ?? this.size,
    );
  }
}

class DrawingElement {
  final List<Offset> points;
  final Color color;
  final double strokeWidth;

  DrawingElement({
    required this.color,
    required this.points,
    required this.strokeWidth,
  });


  DrawingElement copyWith({
    List<Offset>? points,
    Color? color,
    double? strokeWidth,
  }) {
    return DrawingElement(
      color: color ?? this.color,
      points: points ?? this.points,
      strokeWidth: strokeWidth ?? this.strokeWidth,);
  }
}

